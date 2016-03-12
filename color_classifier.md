**Contents:**


# Introduction #

_provides a color classifier node and a corresponding color model training node_


![![](https://lh5.googleusercontent.com/-0W4OjVKnZ9U/UBzPGFx4hQI/AAAAAAAABf8/h5eUVJZj-Fw/s100/color_classifier_laser.png)](https://lh5.googleusercontent.com/-0W4OjVKnZ9U/UBzPGFx4hQI/AAAAAAAABf8/h5eUVJZj-Fw/s1366/color_classifier_laser.png)

# Usage #

## Compile ##

```
rosmake color_classifier
```

## Training ##
### Requirements ###
In order to build a color model, the trainer needs
  1. The image containing pixels of the target color, named in the form: `<name>.<ext>`
  1. One or more binary masks indicating which pixels in the source image are target pixels, named in the form: `<source_image_prefix>_<color_name>_mask.<ext>`

### Example ###

| ![![](https://lh4.googleusercontent.com/-ylEvx-df8-k/UBx_kcOmmsI/AAAAAAAABfg/RyjCMjgdejg/s100/laser_small.jpg)](https://lh4.googleusercontent.com/-ylEvx-df8-k/UBx_kcOmmsI/AAAAAAAABfg/RyjCMjgdejg/s1024/laser_small.jpg) | ![![](https://lh4.googleusercontent.com/-G3Wb9HiMxO4/UBx_j3u8szI/AAAAAAAABfU/EewhH62J7ok/s100/laser_small_center_mask.jpg)](https://lh4.googleusercontent.com/-G3Wb9HiMxO4/UBx_j3u8szI/AAAAAAAABfU/EewhH62J7ok/s1024/laser_small_center_mask.jpg) | ![![](https://lh4.googleusercontent.com/-8spHSUwbazI/UBx_jxHkJWI/AAAAAAAABfQ/ClT3Yo0JviI/s100/laser_small_green_mask.jpg)](https://lh4.googleusercontent.com/-8spHSUwbazI/UBx_jxHkJWI/AAAAAAAABfQ/ClT3Yo0JviI/s1024/laser_small_green_mask.jpg) |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| laser\_small.jpg                                                                                                                                                                                                          | laser\_small\_center\_mask.jpg                                                                                                                                                                                                                    | laser\_small\_green\_mask.jpg                                                                                                                                                                                                                   |

Notice that here, `<source_image_prefix>` is `laser_small` and the two colors we want to train for are `center` and `green` according to the naming scheme.

## Run ##

### color\_classifier\_trainer ###
```
roslaunch color_classifier color_classifier_trainer.launch color:=color_name [folder:=path/to/images frame:=image_name ext:=png/jpg/etc model:=model_name]
```

This will tell the trainer to:
  1. Open `<folder>/<frame>.<ext>` as the source image
  1. Open `<folder>/<frame>_<color>_mask.<ext>` as the mask image
  1. Load existing color model from ``````rospack find color_classifier````/params/<model>.yaml``
  1. Calculate new color parameters according to the input images
  1. Write new color parameters out to ``````rospack find color_classifier````/params/<model>.yaml``

#### Notes ####
  * Only one color within a given model can be trained per call to the trainer. If no `<model>.yaml` exists within color\_classifier/params, you must create an empty one via: `touch ````rospack find color_classifier`````/params/<model>.yaml``
  * If your images are stored within a ROS package: `<some_ros_package>/subfolder`, you can use `folder:=````rospack find <package>`````/subfolder`` when launching the trainer.


---


### color\_classifier ###
```
roslaunch color_classifier color_classifier.launch [source:=/image/topic/name model:=model_name]
```

This will tell the classifier to:
  1. Subscribe to the ROS topic `<source>`
  1. Load the parameters in ``````rospack find color_classifier````/params/<model>.yaml`` onto the parameter server under `/color_classifier/model`

#### Notes ####
  * To view the resulting probability images, use [seabee3\_common/image\_array\_viewer](http://code.google.com/p/seabee3-ros-pkg/wiki/seabee3_common#image_array_viewer)
  * If the classification resulted in abnormally large variances (ie above 150), it may be necessary to manually tune the color model by lowering these variances until the desired classification is reached.

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