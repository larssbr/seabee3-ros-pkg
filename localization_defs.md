**Contents:**


# Introduction #

`localization_defs` provides ROS messages and services as well as `C++` data structures to aid in robot localization.

# Usage #

## Compile ##

```
rosmake localization_defs --rosdep-install
```

## Run ##
`localization_defs` is a **library** and, as such, cannot be run on its own.

# Documentation #

## Messages ##
  * `LandmarkMsg` ( [localization\_defs/LandmarkMsg](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/msg/LandmarkMsg.msg) - Stores the location, orientation, type, and other properties of a _Landmark_
  * `LandmarkMapMsg` ( [localization\_defs/LandmarkMapMsg](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/msg/LandmarkMapMsg.msg) - Stores the dimensions of a _Landmark Map_ along with an array of `LandmarkMsg` messages

## Data Structures ##
  * `class Landmark` ( [landmark\_map/Landmark.h](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/include/landmark_map/Landmark.h), [landmark\_map/Landmark.cpp](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/src/landmark_map/Landmark.cpp) )
    * `struct LandmarkType`
    * `struct ColorIds`
    * `struct ColorDefs`
    * `namespace LandmarkTypes`
      * `class Buoy : Landmark`
      * `class Pinger : Landmark`
      * `class Pipe : Landmark`
      * `class Bin : Landmark`
  * `class LandmarkMap` ( [landmark\_map/LandmarkMap.h](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/include/landmark_map/LandmarkMap.h), [landmark\_map/LandmarkMap.cpp](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/src/landmark_map/LandmarkMap.cpp) )

---

  * `class LandmarkSensor` ( [localization\_tools/LandmarkSensor.h](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/include/localization_tools/LandmarkSensor.h) )
    * `struct SensorType`
    * `namespace LandmarkSensorTypes`
      * `class SonarSensor : LandmarkSensor`
      * `class BuoyFinder : LandmarkSensor`
      * `class PipeFinder : LandmarkSensor`
      * `class BinFinder : LandmarkSensor`
  * `class LocalizationParticle` ( [localization\_tools/LocalizationParticle.h](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/include/localization_tools/LocalizationParticle.h) )
  * `class LocalizationUtil` ( [localization\_tools/LocalizationUtil.h](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/include/localization_tools/LocalizationUtil.h) )