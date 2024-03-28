# Building `docker build -t mandeye .`
# Run : `rocker --x11 --nvidia --network="bridge" mandeye`
# Inside container
# . /rosws/install/setup.sh  && ./Ros2Project.GameLauncher& ros2 run mandeye_unicorn mandeye_unicorn /opt/mid360_config_lio.json 1 /tmp/ /tmp/


ARG ROS_VERSION=humble
ARG UBUNTU_VERSION=jammy

FROM ros:${ROS_VERSION}-ros-base-${UBUNTU_VERSION}

ENV WORKSPACE=/data/workspace

WORKDIR $WORKSPACE

ENV LANG=en_US.UTF-8


# Setup time zone and locale data (necessary for SSL and HTTPS packages)
RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata locales keyboard-configuration curl \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8 \
    && sh -c 'echo "deb [arch=amd64,arm64] http://repo.ros2.org/ubuntu/main `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list' \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - \
    && rm -rf /var/lib/apt/lists/*

# Install the required ubuntu packages - for sim
RUN apt-get update \
    && apt-get install -y \
            libglu1-mesa-dev \
            libxcb-xinerama0 \
            libfontconfig1-dev \
            libnvidia-gl-470 \
            libxcb-xkb-dev \
            libxkbcommon-x11-dev \
            libxkbcommon-dev \
            libxcb-xfixes0-dev \
            libxcb-xinput-dev \
            libxcb-xinput0 \
            libpcre2-16-0 \
            ninja-build \
            unzip \
            ros-${ROS_DISTRO}-ackermann-msgs \
            ros-${ROS_DISTRO}-control-toolbox \
            ros-${ROS_DISTRO}-gazebo-msgs \
            ros-${ROS_DISTRO}-joy \
            ros-${ROS_DISTRO}-navigation2 \
            ros-${ROS_DISTRO}-rviz2 \
            ros-${ROS_DISTRO}-tf2-ros \
            ros-${ROS_DISTRO}-urdfdom \
            ros-${ROS_DISTRO}-vision-msgs \
            ros-${ROS_DISTRO}-cyclonedds \
            ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
            ros-${ROS_DISTRO}-slam-toolbox \
            ros-${ROS_DISTRO}-nav2-bringup \
            ros-${ROS_DISTRO}-pointcloud-to-laserscan \
            ros-${ROS_DISTRO}-teleop-twist-keyboard \
            ros-${ROS_DISTRO}-topic-tools \
            ros-${ROS_DISTRO}-topic-tools \
            ros-${ROS_DISTRO}-nav-msgs \
            python3-colcon-common-extensions \
            python3-pip \
            screen

# Install the required ubuntu packages - for sim


RUN apt-get update \
    && apt-get install -y \
        ros-${ROS_DISTRO}-pcl-ros \
        freeglut3-dev \
        libeigen3-dev \
        git

ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# Download Sim
RUN pip3 install gdown && gdown 1vPmKkDh22U8PtkF13Uli1VPlvYEaZlbD && unzip Ros2Sim.zip  -d .

# Livox SDK2
RUN git clone https://github.com/Livox-SDK/Livox-SDK2.git && mkdir -p Livox-SDK2/build && cd Livox-SDK2/build && cmake .. && make install

COPY src/mandeye_unicorn/ /rosws/

# Build packages - ROS
RUN rm -rf /rosws/mandeye_unicorn/build && . /opt/ros/humble/setup.sh && cd /rosws/ && colcon build  --cmake-args -DCMAKE_BUILD_TYPE=Release

# Copy Livox config
COPY ./mid360_config_lio.json /opt/

COPY ros_entrypoint.sh /ros_entrypoint.sh

RUN  chmod 755 /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
