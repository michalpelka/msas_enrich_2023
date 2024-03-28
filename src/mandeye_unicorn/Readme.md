# Mandeye unicorn ROS 2

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
It should run robot driver, livox listener and everything from MSAS 2023 without any problem.

# Base station
In another terminal run :
``
ros2 run mandeye_unicorn base_station_unicorn
``
I removed all code from base station, but I added simple example to query for map:
![img.png](img.png)

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

