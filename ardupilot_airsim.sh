#!/bin/bash
source ~/venv-ardupilot/bin/activate
nice -n -15 sim_vehicle.py -v ArduCopter -f airsim-copter-tema --sim-address=$WSL_HOST_IP -A "--serial5=uart:/dev/ttyUSB0:420000 --serial6=uart:/dev/ttyUSB1:921600" --out=udp:$AIRSIM_HOST:14550 
