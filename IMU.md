# Introduction #

http://en.wikipedia.org/wiki/Inertial_measurement_unit

The Inertial Measurement Unit (IMU) is a sensor that measures acceleration (both linear and angular) through a combination of accelerometers and gyroscopes. This data can then be integrated to give quantities such as velocity, position, and orientation. Error in acceleration will be accumulated as measurements are integrated, leading to drift in estimates of velocity and position. As such, the device is not optimal and must be calibrated relatively frequently.

# Xsens MTi #

The IMU used on SeaBee is the [Xsens MTi](http://www.xsens.com/en/general/mti). The MTi is technically an Attitude and Heading Reference System (AHRS), meaning that it features built in filters to reduce drift. The IMU is currently mounted in an empty forward camera case in an attempt to reduce noise in its measurements by distancing it from other electrical components.

## Driver ##
Ed's Xsens driver is hosted [here](http://code.google.com/p/seabee3-ros-pkg/source/browse/#git%2Fxsens_driver). It features calibration procedures.