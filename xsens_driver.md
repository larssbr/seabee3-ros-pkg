**Contents:**


# Introduction #

Connects to the first available xSens IMU on `/dev/ttyUSB*` and publishes xsens\_node/IMUData messages @ 110 Hz

# Usage #

## Compile ##

```
rosmake xsens_driver --rosdep-install
```

## Run ##

```
rosrun xsens_driver xsens_driver _usb_index:=#
```

# Documentation #
## Algorithm ##
  1. Instantiate XSensDriver instance
  1. Connect to IMU
  1. Configure IMU
  1. Publish data @ 110 Hz

## Params ##
  * `usb_index [int : 0]` - set the port to connect to: /dev/ttyUSB#

## Published Topics ##
  * `data_calibrated` ( [xsens\_driver/IMUData](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/xsens_driver/msg/IMUData.msg) ) - calibrated data from the IMU
  * `data_raw` ( [xsens\_driver/IMUData](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/xsens_driver/msg/IMUData.msg) ) - raw data from the IMU

## Published Services ##
  * `CalibrateRPYDrift` ( [xsens\_driver/CalibrateRPY](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/xsens_driver/srv/CalibrateRPY.srv) ) - Compensate for drift in the IMU's orientation
  * `CalibrateRPYOri` ( [xsens\_driver/CalibrateRPY](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/xsens_driver/srv/CalibrateRPY.srv) ) - Zero out the IMU's orientation
  * `SetRPYOffset` ( [xsens\_driver/SetRPYOffset](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/xsens_driver/srv/SetRPYOffset.srv) ) - Define a static offset to be applied to the IMU's orientation