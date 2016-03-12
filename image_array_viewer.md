**Contents:**


# Introduction #

Simple utility to view simple component array messages.

# Usage #

## Compile ##

```
rosmake image_array_viewer
```

## Run ##

```
rosrun image_array_viewer image_array_viewer images:=<image array topic>
```

# Documentation #
## Algorithm ##
  1. Magic

## Topic Subscriptions ##
  * `images` ( [ComponentImageArray](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/diamondback/base_libs/msg/ComponentImageArray.msg) ) - color-classified images with id's