This is an end-to-end open-source software for nuclear power plant inspection with mobile robot.
If You have any question please send info to januszbedkowski@gmail.com or add issue to this repository. 

![0](images/0.jpg)

![1](images/1.jpg)

![2](images/2.png)
-----

# base station program
https://github.com/JanuszBedkowski/msas_enrich_2023/blob/master/src/mandeye_unicorn/src/base_station_unicorn.cpp

# robot program
https://github.com/JanuszBedkowski/msas_enrich_2023/blob/master/src/mandeye_unicorn/src/mandeye_unicorn_imu.cpp

# Mandeye unicorn ROS 2

Refer to [Docker file](https://github.com/michalpelka/msas_enrich_2023/blob/master/Dockerfile) for build instruction.

# Prerequisites

You need : 
- ROS 2 Humble (https://docs.ros.org/en/humble/Installation.html)
- Livox SDK 2, compiled and installed from sources : https://github.com/Livox-SDK/Livox-SDK2
- Some other dependencies:
```bash
sudo apt-get install ros-humble-pcl-ros freeglut3-dev libeigen3-dev
```
# Building

Go to mandeye_unicorn workspace and run
```bash
colcon build --packages-select mandeye_unicorn
```

Do not forget to source / add to bash installation:
```bash
source ./install/setup.bash 
```
# Robot node

Start robot node:
```
ros2 run mandeye_unicorn mandeye_unicorn ./mid360_config_lio.json 0 /tmp/ /tmp/
```
It should run robot driver, Livox listener and everything from MSAS 2023 without any problem.

# Base station
In another terminal run :
``
ros2 run mandeye_unicorn base_station_unicorn
``
# Running sim

Install neccessary packages:
```bash
apt-get install ros-${ROS_DISTRO}-ackermann-msgs  ros-${ROS_DISTRO}-control-toolbox ros-${ROS_DISTRO}-gazebo-msgs ros-${ROS_DISTRO}-joy ros-${ROS_DISTRO}-navigation2 ros-${ROS_DISTRO}-rviz2 ros-${ROS_DISTRO}-tf2-ros ros-${ROS_DISTRO}-urdfdom ros-${ROS_DISTRO}-vision-msgs ros-${ROS_DISTRO}-cyclonedds ros-${ROS_DISTRO}-rmw-cyclonedds-cpp ros-${ROS_DISTRO}-slam-toolbox ros-${ROS_DISTRO}-nav2-bringup ros-${ROS_DISTRO}-pointcloud-to-laserscan ros-${ROS_DISTRO}-teleop-twist-keyboard ros-${ROS_DISTRO}-topic-tools ros-${ROS_DISTRO}-topic-tools ros-${ROS_DISTRO}-nav-msgs
```

Download simulator package and unzip and run it
```bash
gdown 1vPmKkDh22U8PtkF13Uli1VPlvYEaZlbD && unzip Ros2Sim.zip  -d .
./Ros2Project.GameLauncher
```

Start robot node, note that you need to point to valid `mid360_config_lio.json` even running sim:
```bash
ros2 run mandeye_unicorn mandeye_unicorn mid360_config_lio.json 1 /tmp/ /tmp/
```

