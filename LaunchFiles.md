**Contents:**


# Introduction #

Launch files automate the starting of nodes, the setting of parameters, and the remapping of topics.

# Drivers #

## xsens\_node.launch ##
  * Starts up an instance of `xsens_node` without any parameters

## seabee3\_driver\_tuned.launch ##
  * Starts an instance of `seabee3_driver` (the high-level driver) and sets all the PID values via params

## seabee3\_driver\_base.launch ##
  * Starts an instance of `seabee3_driver_base` (the low-level driver) and sets the the firing times and values for all firing devices (which currently includes the shooter, dropper1, and dropper2, but which will eventually be changed to include the shooter, the dropper, and the grabber)

## seabee3\_core.launch ##
  * Loads `xsens_node.launch`, `seabee3_driver_tuned.launch`, and `seabee3_driver_base.launch`

# Utilities #

## teleop\_joy.launch ##
  * Starts an instance of `seabee3_teleop` with the correct button mappings for the xbox360 controller
  * Starts an instance of joy

## seabee3\_vision\_tester.launch ##
  * Starts an instance of `image_server`; sets the necessary parameters to load images 00-16 in `seabee3_launch/frames/` and publish one image per two seconds (0.5 Hz)