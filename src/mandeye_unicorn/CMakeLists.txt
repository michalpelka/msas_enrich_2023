cmake_minimum_required(VERSION 3.5)
project(mandeye_unicorn)
set(CMAKE_CXX_STANDARD 17)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)
find_package(nav_msgs REQUIRED)
find_package(visualization_msgs REQUIRED)
find_package(pcl_ros REQUIRED)
find_package(tf2_ros REQUIRED)
find_package(pcl_conversions REQUIRED)
find_package(PCL REQUIRED)

find_package(OpenGL REQUIRED)
if(OpenGL_FOUND)
message("OpenGL found")
message ("OPENGL_LIBRARIES: " ${OPENGL_LIBRARIES})
endif()

find_package(GLUT REQUIRED)
if(GLUT_FOUND)
message("GLUT found")
message ("GLUT_glut_LIBRARY: " ${GLUT_glut_LIBRARY})
endif()

find_package( Eigen3 REQUIRED)
if(EIGEN3_FOUND)
message("EIGEN3 found")
message ("EIGEN3_INCLUDE_DIR: " ${EIGEN3_INCLUDE_DIR})
message ("EIGEN3_INCLUDE_DIRS: " ${EIGEN3_INCLUDE_DIRS})
message ("Eigen3_DIR: " ${Eigen3_DIR})
endif()

find_package(PCL 1.5 REQUIRED)
find_library(LIVOX_LIDAR_SDK_LIBRARY  liblivox_lidar_sdk_static.a    /usr/local/lib)

include_directories(
${EIGEN3_INCLUDE_DIR}
${EIGEN3_INCLUDE_DIRS}
${Eigen3_DIR}
${PCL_INCLUDE_DIRS}
)

include_directories(src/3rd/imgui src/3rd/imgui/backends src/3rd/)

set(ImGui_Glut_src 
src/3rd/imgui/imgui.cpp 
src/3rd/imgui/imgui_demo.cpp 
src/3rd/imgui/imgui_draw.cpp 
src/3rd/imgui/imgui_widgets.cpp
src/3rd/imgui/backends/imgui_impl_glut.cpp 
src/3rd/imgui/backends/imgui_impl_opengl2.cpp
src/3rd/imgui/imgui_widgets.cpp
src/3rd/imgui/imgui_tables.cpp
)

include_directories(
	src/3rd/Fusion/Fusion
)

set(FUSION 
	src/3rd/Fusion/Fusion/FusionAhrs.c
	src/3rd/Fusion/Fusion/FusionCompass.c
	src/3rd/Fusion/Fusion/FusionOffset.c
)

include_directories(
  src/
  src/3rd/ImGuizmo
)

add_subdirectory(src/3rd/LASzip/)
include_directories(
src/3rd/LASzip/include
src/3rd/portable-file-dialogs-master
)

set(GIZMO 
src/3rd/ImGuizmo/ImGuizmo.cpp
)

add_library(pch src/pch.cpp)
add_library(ImGui ${ImGui_Glut_src}  ${GIZMO})
add_library(Fusion ${FUSION})

add_executable(mandeye_unicorn src/mandeye_unicorn.cpp)
ament_target_dependencies(mandeye_unicorn rclcpp  nav_msgs std_msgs visualization_msgs tf2_ros pcl_ros)
target_link_libraries(mandeye_unicorn ${OPENGL_LIBRARIES} ${PCL_LIBRARIES} ${GLUT_glut_LIBRARY}
 pthread glut  ${catkin_LIBRARIES} ${LIVOX_LIDAR_SDK_LIBRARY} laszip pch ImGui Fusion
)

add_executable(base_station_unicorn src/base_station_unicorn.cpp ${ImGui_Glut_src} ${FUSION} ${GIZMO})
ament_target_dependencies(base_station_unicorn rclcpp  nav_msgs std_msgs visualization_msgs tf2_ros pcl_ros)
target_link_libraries(base_station_unicorn ${OPENGL_LIBRARIES} ${PCL_LIBRARIES} ${GLUT_glut_LIBRARY}
 pthread glut  ${catkin_LIBRARIES} ${LIVOX_LIDAR_SDK_LIBRARY} laszip
)

install(TARGETS
		mandeye_unicorn base_station_unicorn
		DESTINATION lib/${PROJECT_NAME})


ament_package()