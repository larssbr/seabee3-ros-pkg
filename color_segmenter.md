**Contents:**


# Introduction #

Reads images from an arbitrary image topic and segments out certain pre-defined Hue and Saturation values, returning an array of ColorBlobs found in the image.

# Proposed Changes #
This node is being revised. The proposed changes are described below on a per-user basis:

## Mike Gerow ##

  * General overview:  From what I gather, the current color\_segmenter does not use data from color\_classifier, opting to sift through the colors on its own.  So, using the output from color\_classifier would be a place to start.  As for an actual algorithm to divide out segments, I'm still not quite sure about what to use.  OpenCV could have some useful stuff, so learning more about it would definitely help.
  * Required research: Reading up on possibly useful OpenCV functions to help accomplish the task.  Also, looking up other algorithms that could be useful.
  * tl;dr  Read books, discover algorithm, write code, get shit done.
  * Algorithm:
    1. Convert to a black and white image (with white being the target color and black being everything else).  I'm sure this should be easy to do with OpenCV, but I haven't found a great way to do it yet.
    1. Run algorithm on what is left.  Either some kind of search or cv::floodFill.  Documentation for cv::floodFill [here](http://opencv.willowgarage.com/documentation/cpp/miscellaneous_image_transformations.html?highlight=fill#floodFill).

  * Created an image to test the algorithm [here](http://i.imgur.com/pLnGu.png).
  * It is now very close to actually working.  [a test run can be seen here](http://i.imgur.com/h8KNq.png).  While this image does appear to show that image\_segmenter is working, I actually have a fairly frustrating problem that I have to deal with.  Upon testing it the first time I discovered that the x and y values seem to be reversed.  It shouldn't be too hard to fix, though.  For this image I cheated and simply had it draw the coordinates reversed (y, x) just to show that it is, in fact, pretty close to actually working.

  * Ok, now everything REALLY seems to be working, all except it returns the incorrect color number.  It seems like it would be a really easy to fix, but I haven't looked at it yet.  Anyway, here it is finding all the black in an image:  [PICTURE!](http://imgur.com/Gzvjh.png).

# Current Implementation #


---


# Usage #

## Compile ##

```
rosmake color_segmenter --rosdep-install
```

## Run ##

```
rosrun color_segmenter color_segmenter image:=/path/to/image/topic [ _show_dbg_img:=<int>  _show_dbg_color:=<color name> ]
```

# Documentation #
## Algorithm ##
  1. Listen for requests
  1. Segment the image for the color specified in the request
  1. Return the blobs segmented out of the image
## Params ##
  * `show_debug_img [int : 1]` - whether or not to publish the debug image
  * `debug_color [string : "red"]` - which color to segment when generating the debug image

## Topic Subscriptions ##
  * `image` ( [sensor\_msgs/Image](http://www.ros.org/doc/api/sensor_msgs/html/msg/Image.html) ) - Image topic to use for color segmentation

## Published Topics ##
  * `find_blobs` ( [color\_segmenter/FindBlobs](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/color_segmenter/srv/FindBlobs.srv) ) - Service to segment the most recent image
  * `debug/image_color` ( [sensor\_msgs/Image](http://www.ros.org/doc/api/sensor_msgs/html/msg/Image.html) ) - Image topic to which the debug image is written