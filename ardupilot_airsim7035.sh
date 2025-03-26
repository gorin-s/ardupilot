#!/bin/bash
SIM_VEHICLE=airsim-copter-tema7035
UART_ERLS=/dev/ttyUSB0
while getopts ':w' opt; do
    case "$opt" in
        w)
            REINIT_SITL=-w;
            echo "Ardupilot SITL is re-initialized. Stored config will be reset"
            ;;
        ?)
            echo -e "Invalid command option.\nUsage: $(basename $0) [-w]"
            exit 1
            ;;
    esac
done

source ~/venv-ardupilot/bin/activate
WSL_HOST_IP=$(ipconfig.exe | awk '/WSL/ {getline; getline; getline; getline; print substr($14, 1, length($14)-1)}')
export DISPLAY=:0
if [ ! -e $UART_ERLS ]; then
    echo "$UART_ERLS is not found. Run 'usbipd attach --wsl --busid <BUSID>' from Windows Host"
    echo "You may also want to use --auto-attach option to skip this step in future"
    sleep 5
fi
sim_vehicle.py -v ArduCopter -f $SIM_VEHICLE $REINIT_SITL --sim-address=$WSL_HOST_IP -A "--serial5=uart:$UART_ERLS:420000" --out=udp:$WSL_HOST_IP:14550 --out=udp:$WSL_HOST_IP:14552 --osd