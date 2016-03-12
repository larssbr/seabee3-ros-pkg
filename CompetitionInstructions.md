**Contents:**


# Introduction #

The following instructions provide a manual on how to prepare and run Seabee for competition.


# Software #

## Quickstart (automated start) ##
### SSH into Seabee ###

```
ssh uscr@192.168.1.130
```
**enter password**

(run startup script)

## Detailed Start (manual start) ##

```
ssh uscr@192.168.1.130
```
**enter password**

Start up the IMU driver (if you start seabee3\_driver first, bad things will happen [Issue #1](see.md), so DON'T do it).
```
roslaunch xsens_driver xsens_driver.launch
```

Start seabee3\_driver
```
roslaunch seabee3_driver seabee3_driver.launch
```

Start seabee3\_controls
```
roslaunch seabee3_controls seabee3_controls.launch
```

Run seabee3\_physics
```
roslaunch seabee3_physics seabee3_physics.launch
```

### Manual Control ###

The following instructions are for teleoping seabee (controlling it manually). All of the following commands should be **run on your computer**:
Setup environment variables to connect to seabee
This is telling your computer to look for seabee on the network:
```
export ROS_MASTER_URI=http://192.168.1.130:11311
```
```
export ROS_IP=<your ip>
```

Start up the joystick driver:
```
seabee3_teleop seabee3_teleop.launch use_ps3:=true
```