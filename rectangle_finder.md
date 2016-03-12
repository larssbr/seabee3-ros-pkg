**Contents:**


# Introduction #

rectangle\_finder receives requests to find rectangles of certain proportions in the most recent image and then returns the list of rectangles that match those specifications.

# Proposed Changes #
This node is being revised. The proposed changes are described below on a per-user basis:

## Tasha McCailey ##

  * General overview:
  * Required research:
  * Algorithm:
    1. Start up
    1. Do something useful
    1. ???
    1. Profit.

# Current Implementation #


---


# Usage #

## Compile ##

```
rosmake rectangle_finder
```

## Run ##

```
rosrun rectangle_finder rectangle_finder image:=/path/to/image/topic
```

# Documentation #
## Algorithm ##
  1. Start up
  1. Do something useful
  1. ???
  1. Profit.

## Params ##
  * `<param name> [<param type> : <default value>]` - _info_

## Topic Subscriptions ##
  * `<topic name>` ( [topic\_message\_type](link_to_topic_message_type.md) ) - _info_

## Published Topics ##
  * `<topic name>` ( [topic\_message\_type](link_to_topic_message_type.md) ) - _info_

## Published Services ##
  * `find_rectangles` ( [FindRectangles](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/cturtle/rectangle_finder/srv/FindRectangles.srv) ) - find rectangles in the most recent image and return the resulting list