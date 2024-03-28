#!/bin/sh
. /rosws/install/setup.sh  && ./Ros2Project.GameLauncher& 
screen -dm bash -c '. /rosws/install/setup.sh  &&  ros2 run mandeye_unicorn mandeye_unicorn /opt/mid360_config_lio.json 0 /tmp/ /tmp/'
. /rosws/install/setup.sh  &&  ros2 run mandeye_unicorn base_station_unicorn


