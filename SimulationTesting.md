# Introduction #

This page contains all the information to test Seabee3.


# Physics Simulator #


## Test ##
In order to test seabee3\_physics with a controller, you will have to run the following in different terminals:

Core drivers for running nodes:
```
roscore
```

Launch file for running seabee3\_physics:
```
seabee3_physics seabee3_physics.launch
```

Launch file for seabee3\_driver, which is a higher level node that sets thruster values on the hardware:
```
seabee3_driver seabee3_driver.launch simulate:=true
```
The simulate:=true statement signifies that we are not trying to run this on the actual sub.

This launches the highest level controller which identifies the current and desired locations for the sub and calculates the motor values and sends them to seabee3\_driver.
```
seabee3_controls seabee3_controls.launch
```

This launches the joystick controller that modifies the desired position of the sub via interpreting input from the controller.

If you're using an xbox 360 controller, type this:
```
seabee3_teleop seabee3_teleop.launch use_xbox360:=true
```

If you're using a ps3 controller, type this:
```
seabee3_teleop seabee3_teleop.launch use_ps3:=true
```

This launches the software that lets you visualize seabee3\_physics.
```
rosrun rviz rviz
```