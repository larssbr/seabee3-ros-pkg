**Contents:**


# Introduction #

landmark\_map\_server reads a map from a .yaml file and publishes it via a `localization_defs/LandmarkMapMsg` message and an array of `visualization_msgs/Marker messages`


![![](http://lh4.ggpht.com/_EiQADOyrLss/TDPgPBsg95I/AAAAAAAAAyg/6GE3jAzecig/s128/landmark_map_server-orbit.png)](http://lh4.ggpht.com/_EiQADOyrLss/TDPgPBsg95I/AAAAAAAAAyg/6GE3jAzecig/landmark_map_server-orbit.png)

![![](http://lh4.ggpht.com/_EiQADOyrLss/TDPgPT9PzZI/AAAAAAAAAyk/RUn3yup-p78/s128/landmark_map_server-top.png)](http://lh4.ggpht.com/_EiQADOyrLss/TDPgPT9PzZI/AAAAAAAAAyk/RUn3yup-p78/landmark_map_server-top.png)

# Usage #

## Compile ##

```
rosmake landmark_map_server --rosdep-install
```

## Run ##

```
rosrun landmark_map_server _map_uri:=/path/to/map.yaml
```

## Map File Syntax ##
  * Each landmark type has a type, center, ori, and optional extra options. See [Landmark.h](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/include/landmark_map/Landmark.h) for all available Landmarks, values, and options.
```
dim: [<x>, <y>]
landmarks:
- type: <landmark1_type>
  center: [<x>, <y>, <z>]
  ori: <orientation>
  <other opt>: <value>
- type: <landmark2_type>
  center: [<x>, <y>, <z>]
  ori: <orientation>
  <other opt>: <value>

```

# Documentation #
## Algorithm ##
  1. Read in .yaml map file
  1. Parse map into `localization_defs::Landmark` objects
  1. Store landmarks in a `localization_defs::LandmarkMap` object
  1. Call `LandmarkMap::createMsg()` to generate a `localization_defs::LandmarkMapMsg` message
  1. Call `Landmark::createMsg()` on each landmark to generate a `visualization_msgs::Marker` for each landmark
  1. Publish the `LandmarkMapMsg` for `flsl`
  1. Publish the `Marker` messages for `rviz`

## Params ##
  * `map_uri [string : "null"]` - Map file to open
  * `map_frame [string : "/landmark_map"]` - Frame at which the map will be centered (for visualization in rviz)

## Published Topics ##
  * `landmarks` ( [visualization\_msgs/Marker](http://www.ros.org/doc/api/visualization_msgs/html/msg/Marker.html) ) - Visualization of landmarks in `rviz`
  * `landmark_map` ( [localization\_defs/LandmarkMapMsg](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/localization_defs/msg/LandmarkMapMsg.msg) ) - Parsed map for use with `flsl`