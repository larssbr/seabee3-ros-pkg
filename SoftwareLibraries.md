**Contents:**


# localization\_defs #

  * [localization\_defs](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/cturtle/localization_defs/)
  * Provides methods to convert between abstract landmarks, visualization\_msgs::Marker messages, and localization\_defs::Landmark messages

# libseabee3\_beestem #

  * [libseabee3\_beestem](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/#trunk/cturtle/libseabee3_beestem)

  * Provides methods for low-level communication between C++ code and the microcontroller on the power board. Stores relevant low-level software/electrical/hardware data such as human-readable thruster index mappings.

# libxsens #

  * [libxsens](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/#trunk/cturtle/libxsens)

  * Provides a low-level communication driver for the XSens MTi IMU.

# base\_image\_proc #

  * [base\_image\_proc](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/#trunk/cturtle/base_image_proc)

## Usage ##

  1. Add `<depend package="base_image_proc"/>` to the manifest for your project
  1. `#include <base_image_proc/base_image_proc.h>` in the source for your node
  1. Inherit from `BaseImageProc<_ReconfigureType, [_ServiceType]>`
  1. Use your own config type or `BaseImageProcSettings::_DefaultReconfigureType` as `_ReconfigureType`
  1. If you don't use the default reconfigure type:
    1. Call `initCfgParams()` in your constructor
    1. Override `virtual void reconfigureCB( Types::_ReconfigureType & config, uint32_t level )`
  1. Choose a mode:
    * Publish + subscribe mode
      1. Override `virtual cv::Mat processImage( IplImage * ipl_img )`
      1. At some point, construct a `cv::Mat` from `ipl_img` using `cv::Mat( ipl_img )`
      1. Modify the the outbound image ( `cv_img_` ) and return it
    * Service mode
      1. Change `_ServiceType` to match the base class of your service; all services have both a `Request` and a `Response`, so if you were using `std_srvs::Empty::Request` and `std_srvs::Empty::Response`, simply use `std_srvs::Empty` as `_ServiceType`
      1. Override `virtual cv::Mat processImage( IplImage * ipl_img, _ServiceRequest & req, _ServiceResponse & resp )`
      1. Given the data in `req`, process the image and fill the properties of `resp`
      1. Optionally modify the outbound image and return it


## base\_image\_proc\_core.h ##

  * `class BaseImageProcCore`: Core, common parameters and methods shared by all image\_proc nodes.
  * `struct ReconfigureSettings`: Specialized templated struct used to enable/disable functionality, specifically that related to dynamic\_reconfigure, depending on the template types used.

## base\_image\_proc.h ##

  * `class BaseImageProc`: Templated class used to enable/disable functionality related to services depending on the template parameters provided.

  * `struct BaseImageProcSettings`: Struct used solely to provide the type `_DefaultReconfigureType` which should be provided to BaseImageProc by nodes that don't intend to use the features of dynamic reconfigure.