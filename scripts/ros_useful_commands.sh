#!/bin/bash

# to be properly put into a launch file
roslaunch urdf_tutorial display.launch model:=urdf/marcel.urdf

roslaunch urdf_sim_tutorial gazebo.launch model:=urdf/marcel.urdf
