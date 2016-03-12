**Contents:**


# Introduction #

image\_server is a utility used to publish image\_transport messages from a sequence of image files on disk (e.g. from a directory of .jpeg, .png, etc... files).
# Usage #

## Compile ##

rosmake image\_server --rosdep-install

## Run ##

`rosrun image_server image_server _prefix=<image file prefix> _start=<first frame number> _end=<last frame number> _digits=<number of digits in file numbers> _ext=<file extension> _rate=<rate (in  hz) to publish frames> _loop=<whether or not to loop the video>`

So, for example if you had a directory filled with a sequence of images in /home/uscr/Videos/ExampleVideo with filenames myVideo00001.jpg - myVideo00100.jpg you would run:

`rosrun image_server image_server _prefix:=/home/uscr/Videos/ExampleVideo/myVideo _start:=1 _end:=100 _digits:=5 _ext:=.jpg _rate:=15`

# Documentation #
## Algorithm ##
  1. Step1: Open the video
  1. Step2: Play the video
  1. Step3: Profit!

## Params ##
  * `prefix [string : ""]` - The beginning of the common part of the file names (including the path)
  * `start [int : 0]` - The first frame number
  * `end [int : ]` - The last frame number
  * `digits [int : 0]` - The number of digits in the frame numbers
  * `ext [string : ""]` - The file extension of the files (be sure to include the dot)
  * `rate [int : 15]` - The sending rate of the video
  * `loop [bool : false]` - Whether or not to loop over the video


## Topic Subscriptions ##
  * None

## Published Topics ##
  * `image_server/output_image` ( [sensor\_msgs/Image](http://www.ros.org/doc/api/sensor_msgs/html/msg/Image.html) ) - the color-classified imageframe.