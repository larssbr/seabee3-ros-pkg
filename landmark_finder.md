**Contents:**


# Introduction #

Uses the available sensor nodes to find the set of a given type of landmark in the current environment. This is the most high-level vision component in the hierarchy; it depends directly on the low-level algorithms which identify basic shapes and colors, then determines which landmarks, if any, exist within view of the robot's sensors.


![![](http://lh3.ggpht.com/_EiQADOyrLss/TDX3UG1pUNI/AAAAAAAAAy8/dbfb6ODHAcg/s128/landmark_finder-buoy.png)](http://lh3.ggpht.com/_EiQADOyrLss/TDX3UG1pUNI/AAAAAAAAAy8/dbfb6ODHAcg/s1600/landmark_finder-buoy.png)

# Usage #

## Compile ##

```
rosmake landmark_finder --rosdep-install
```

## Run ##

```
rosrun landmark_finder landmark_finder
```

# Documentation #
## Algorithm ##
  1. Publish services for known landmarks
  1. Wait for a service request
  1. Upon receiving a request, send a service request to the appropriate nodes (rectangle\_finder, color\_segmenter, sonar\_node, etc) to process the most recent sensor data for certain features
  1. Analyze the resulting messages; construct Landmark instances for each landmark found in the combined sensor data
  1. Call `Landmark::createMsg()` for each landmark and add the resulting message to the list of landmarks to be returned to the caller of the service
  1. Call `Landmark::createMarker()` for each landmark and add the resulting message to the marker queue
  1. At each time-step, publish the markers in the marker queue

## Params ##
  * `buoy_finder/run_demo [int : 0]` - Setting this option to 1 will run the program in demo mode; it will look for red and blue buoys and publish them at 3 Hz
  * `buoy_finder/blob_params/heading_corr [double : 1.0]` - Amount by which to scale the y-offset of the buoy when converting from camera coordinates to world coordinates
  * `buoy_finder/blob_params/depth_corr [double : 1.0]` - Amount by which to scale the z-offset of the buoy when converting from camera coordinates to world coordinates
  * `buoy_finder/blob_params/distance_scale [double : 7000.0]` - Amount by which to scale the x-offset of the buoy when converting from camera coordinates to world coordinates

## Topic Subscriptions ##
  * `/color_segmenter/segment_image` ( [color\_segmenter/SegmentImage](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/color_segmenter/srv/SegmentImage.srv) ) - Request for the color segmenter to segment the most recent image

## Published Topics ##
  * `find_buoys` ( [landmark\_finder/FindLandmark](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/landmark_finder/srv/FindLandmarks.srv) ) - Request to find all buoys
  * `find_pipes` ( [landmark\_finder/FindLandmark](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/landmark_finder/srv/FindLandmarks.srv) ) - Request to find all pipes
  * `find_bins` ( [landmark\_finder/FindLandmark](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/landmark_finder/srv/FindLandmarks.srv) ) - Request to find all bins
  * `find_pingers` ( [landmark\_finder/FindLandmark](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/landmark_finder/srv/FindLandmarks.srv) ) - Request to find all pingers
  * `find_windows` ( [landmark\_finder/FindLandmark](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/landmark_finder/srv/FindLandmarks.srv) ) - Request to find all windows