**Contents:**


# Introduction #

Converts `joy/Joy` messages to `geometry_msgs/Twist` messages for processing by [http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3\_driver seabee3\_driver](.md)

# Usage #

## Compile ##

```
rosmake seabee3_teleop --rosdep-install
```

## Run ##

```
rosrun seabee3_teleop seabee3_teleop
```

# Documentation #
## Algorithm ##
  1. Subscribe to `joy/Joy` message
  1. Convert joystick+button values into `geometry_msgs/Twist` messages
  1. Publish `Twist` messages

## Params ##
  * `speed [int : 0]` - joystick axis to control x-axis translation
  * `strafe [int : 1]` - joystick axis to control y-axis translation
  * `surface [int: 2]` - joystick axis to increase z-axis translation
  * `dive [int : 5]` - joystick axis to decrease z-axis translation
  * `heading [int : 4]` - joystick axis to control z-axis rotation (yaw)
  * `roll [int : 3]` - joystick axis to control x-axis rotation (roll)
  * `speed_scale [double : 1.0]` - scale of speed axis
  * `strafe_scale [double : 1.0]` - scale of strafe axis
  * `surface_scale [double : 1.0]` - scale of surface axis
  * `dive_scale [double : 1.0]` - scale of dive axis
  * `heading_scale [double : 1.0]` - scale of heading axis
  * `roll_scale [double : 1.0]` - scale of roll axis

## Topic Subscriptions ##
  * `joy` ( [joy/Joy](http://www.ros.org/doc/api/joy/html/msg/Joy.html) ) - Message containing axis and button values for a joystick

## Published Topics ##
  * `/seabee3/cmd_vel` ( [geometry\_msgs/Twist](http://www.ros.org/doc/api/geometry_msgs/html/msg/Twist.html) ) - Message containing desired linear + angular velocities to be processed by `seabee3_driver`