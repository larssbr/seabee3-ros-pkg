**Contents:**


# Introduction #

Calculates statistics of color blobs in images. Specifically, given an array of color-classified images, uhh, just segments color blobs in those images. And returns a list of color blob messages.

# Usage #

## Compile ##

```
rosmake color_blob_finder
```

## Run ##

```
rosrun color_blob_finder color_blob_finder images:=<image array topic>
```

You must call the service:

```
color_blob_finder/find_color_blobs
```

# Documentation #
## Algorithm ##
  1. Receive array of images
  1. Wait for service call
  1. For each unique requested color
    1. Segment color blobs
    1. Calculate statistics for each blob
  1. Publish color blob array message


## Topic Subscriptions ##
  * `images` ( [ComponentImageArray](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/diamondback/base_libs/msg/ComponentImageArray.msg) ) - color-classified images with id's

## Published Topics ##
  * `color_blobs` ( [ColorBlobArray](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/diamondback/color_blob_finder/msg/ColorBlobArray.msg) ) - array of color blobs