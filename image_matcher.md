**Contents:**


# Introduction #

image\_matcher determines the likelihood that a the most recent camera image contains each of a list of pre-defined candidate images

# Proposed Changes #
This node is being revised. The proposed changes are described below on a per-user basis:

## Kaylyn Sung ##

  * General overview:
  * Required research:
  * Algorithm:
    1. Start up
    1. Do something useful
    1. ???
    1. Profit.

## Dhruv Monga ##

  * General overview:I am going to try to implement Zernike Moments as a more efficient form of image recognition.
  * Required research: Look more into Zernike moments and how the algorithm works.
  * Algorithm:
Preprocessing:
    1. Convert Image to Black and White (NOT grayscale)
    1. Possibly scale the images to make them easier to process
    1. Identify Zernike Moments for the template images
Processing:
    1. Find Zernike Moments for the scaled images of the object
    1. Find percent similarities for each image with respect to each template
    1. Match highest percentages
    1. Assign each image to the appropriate template

## Jose Herrera ##

  * General overview: Comparing image shapes by comparing moments of the image.
  * Required research: Look into moments, including Legendre, Zernike, and other moments.
  * Algorithm:
    1. Take in boundaries of objects for reference image and image being analyzed.
    1. Boundaries will be in the form of a set of points, with and x and y coordinates.
    1. (At this point, we can either compute the moments from the data, or take a Discrete Fourier Transform)
    1. For moments:
      * Perform the specified (Legendre, Zernike, or otherwise) moment computation.
    1. For a DFT:
      * Center boundaries to a coordinate system.
      * Create a complex set of numbers of the form z = x + j\*y from the coordinates for each boundary (one for each image).
      * Now, we can perform 1 dimensional analyses of the data.
      * Take a DFT (using FFT) of the data and use this for analysis.
        * Any rotation of the original image by an angle will be a simple constant multiplication by e^(j\*angle).
        * Likewise, any scaling will a constant multiplication by the scaling factor.
        * Any translation by (x,y) will be an addition of (x,y) times an impulse at the 0 frequency.
        * Any change in counting (calling point 1 point k, for instance) will result in the a multiplicative change of e^(j\*2pi\*k\*w/K), where K is the number of data points in the DFT, and w is frequency.
    1. Having either a moment or a DFT, we can drop unimportant terms, and focus only on those terms which best describe the image (for the DFT, keep only highest amplitude frequencies). In this way, we can accurately describe an image border by a very small number of points.
    1. Now having either moments or DFT descriptors for both boundaries, compare them, taking into account possible rotation, scaling, etc.
    1. Use good values for discrepancies and take them into account, and output result of comparison.

# Current Implementation #


---


# Usage #

## Compile ##

```
rosmake image_matcher
```

## Run ##

```
rosrun image_matcher image_matcher image:=/path/to/image/topic
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
  * `image` ( [sensor\_msgs/Image](http://www.ros.org/doc/api/sensor_msgs/html/msg/Image.html) ) - the input image to process

## Published Services ##
  * `match_image` ( [image\_matcher/MatchImage](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/cturtle/image_matcher/srv/MatchImage.srv) ) - a service requesting for the node to generate matches for known images; the service contains an empty request; the response is the quality of the match for each candidate image