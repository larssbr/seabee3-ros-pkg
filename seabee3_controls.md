**Contents:**


# Introduction #

Processes `geometry_msgs/Twist` messages into motor values based on IMU data and several PID control loops.

# Usage #

## Compile ##

```
rosmake seabee3_controls --rosdep-install
```

## Run ##

```
rosrun seabee3_controls seabee3_controls imu_data:=/path/to/topic odom_prim:=/path/to/topic
```

# Documentation #
## Algorithm ##
  1. Listen on the `/seabee3/cmd_vel` topic for `geometry_msgs/Twist` messages
    1. Record desired linear and angular velocities
    1. Set desired speed from `lin.x`
    1. Set desired strafe from `lin.y`
    1. Calculate desired change in depth from `lin.z`
    1. Calculate desired change in `<R, P, Y>` from `<ang.x, ang.y, ang.z>`
  1. At each time-step, update the PID control loops and the motor control message
    1. Reset the motor control message
      1. Set `mask[*]` of the motor control message to 0
      1. Set `motor[*]` of the motor control message to 0
    1. Add the desired change in RPY per second to the current desired RPY
    1. Add the desired change in depth per second to the current desired depth
    1. Normalize the RPY angles
    1. Calculate the current error in RPY
    1. Calculate the current error in depth
    1. Cap the error values at the specified caps
    1. Set the speed motor value to the current desired speed value
    1. Set the strafe motor value to the current desired strafe value
    1. Set the depth motor value to the output of the depth PID loop, given the current error in depth
    1. Set the R,P,Y motor values to the output of the R,P,Y PID loops given the current error in R,P,Y
    1. Update the motor control message with the desired motor values
      1. Calculate the orientation of the robot according to the IMU
      1. Combine and scale each desired movement function according to the current thruster configuration and current orientation of the robot
  1. At each time-step, publish the motor control message

## Params ##
  * `depth_err_cap [double : 25.0]` - Cap the error in depth at this value
  * `roll_err_cap [double : 25.0]` - Cap the error in roll at this value
  * `pitch_err_cap [double : 25.0]` - Cap the error in pitch at this value
  * `heading_err_cap [double : 25.0]` - Cap the error in heading at this value

---

  * `pid/D/p [double : 2.5]` - depth `P`
  * `pid/D/i [double : 0.05]` - depth `I`
  * `pid/D/d [double : 0.2]` - depth `D`

---

  * `pid/R/p [double : 2.5]` - roll `P`
  * `pid/R/i [double : 0.05]` - roll `I`
  * `pid/R/d [double : 0.2]` - roll `D`

---

  * `pid/P/p [double : 2.5]` - pitch `P`
  * `pid/P/i [double : 0.05]` - pitch `I`
  * `pid/P/d [double : 0.2]` - pitch `D`

---

  * `pid/Y/p [double : 2.5]` - heading `P`
  * `pid/Y/i [double : 0.05]` - heading `I`
  * `pid/Y/d [double : 0.2]` - heading `D`

---

  * `pid/i_max [double : 1.0]` max `I` for all PID control loops
  * `pid/i_min [double : -1.0]` - min `I` for all PID control loops

---

  * `speed_m1_dir [double : 1.0]` - Define the positive rotation direction of the `speed:1` thruster
  * `speed_m2_dir [double : 1.0]` - Define the positive rotation direction of the `speed:2` thruster

---

  * `strafe_m1_dir [double : 1.0]` - Define the positive rotation direction of the `strafe:1` thruster
  * `strafe_m2_dir [double : 1.0]` - Define the positive rotation direction of the `strafe:2` thruster

---

  * `depth_m1_dir [double : 1.0]` - Define the positive rotation direction of the `depth:1` thruster
  * `depth_m2_dir [double : 1.0]` - Define the positive rotation direction of the `depth:2` thruster

---

  * `roll_m1_dir [double : 1.0]` - Define the positive rotation direction of the `roll:1` thruster
  * `roll_m2_dir [double : 1.0]` - Define the positive rotation direction of the `roll:2` thruster

---

  * `heading_m1_dir [double : 1.0]` - Define the positive rotation direction of the `heading:1` thruster
  * `heading_m2_dir [double : 1.0]` - Define the positive rotation direction of the `heading:2` thruster

---

  * `speed_axis_dir [double : 1.0]` - Define the direction of the speed axis
  * `strafe_axis_dir [double : 1.0]` - Define the direction of the strafe axis
  * `depth_axis_dir [double : -1.0]` - Define the direction of the depth axis
  * `roll_axis_dir [double : -1.0]` - Define the direction of the roll axis
  * `pitch_axis_dir [double : -1.0]` - Define the direction of the pitch axis
  * `heading_axis_dir [double : -1.0]` - Define the direction of the heading axis

## Topic Subscriptions ##
  * `/seabee3/cmd_vel` ( [gometry\_msgs/Twist](http://www.ros.org/doc/api/geometry_msgs/html/msg/Twist.html) ) - Desired linear and angular velocities being sent in by control nodes such as [seabee3\_teleop](http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3_teleop) or [waypoint\_controller](http://code.google.com/p/seabee3-ros-pkg/wiki/waypoint_controller)

## Published Topics ##
  * `/seabee3/motor_cntl` ( [seabee3\_driver\_base/MotorCntl](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/cturtle/seabee3_driver/msg/MotorCntl.msg) ) - Raw thruster values to be set by [seabee3\_driver](http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3_controls)
  * `/seabee3/set_desired_pose` ( [seabee3\_driver/setDesiredPose](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/cturtle/seabee3_controls/srv/SetDesiredPose.srv) ) - Service to allow other nodes to set/increment the desired 6-DOF pose of the robot