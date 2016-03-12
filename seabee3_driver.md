**Contents:**


# Introduction #

Communicates with SeaBee3's micro-controller to read internal/external pressure values and set the voltage of motor drivers on the power board.

# Usage #

## Compile ##

```
rosmake seabee3_driver --rosdep-install
```

## Run ##

```
rosrun seabee3_driver seabee3_driver_base _usb_index:=#
```

# Documentation #
## Algorithm ##
  1. Instantiate BeeStem3Driver instance
  1. Fetch + publish pressure values
  1. Fetch + publish kill switch status
  1. Set state of motor drivers

## Thruster Mappings ##
These are the mappings from thruster to position in the `motors` vector in the `seabee3_driver/motor_vals` message.

From `seabee3_common/include/seabee3_common/movement.h`:
```
namespace MotorControllerIDs
{
    // 0 and 2 have been swapped                                                                                                                                                   
    static int const FWD_RIGHT_THRUSTER = 3; // RR                                                                                                                                 
    static int const FWD_LEFT_THRUSTER = 1; // LL                                                                                                                                  
    static int const DEPTH_FRONT_THRUSTER = 2; // LB                                                                                                                               
    static int const DEPTH_BACK_THRUSTER = 5; // RT                                                                                                                                
    static int const STRAFE_TOP_THRUSTER = 4; // RB                                                                                                                                
    static int const STRAFE_BOTTOM_THRUSTER = 0; // LT                                                                                                                             
    static int const SHOOTER = 6;
    static int const DROPPER_STAGE1 = 7;
    static int const DROPPER_STAGE2 = 8;

    static inline bool isThruster( int const & id )
    {
        return id != SHOOTER && id != DROPPER_STAGE1 && id != DROPPER_STAGE2;
    }
}

```

## Params ##
  * `usb_index [int : 0]` - set the port to connect to: /dev/ttyUSB#

## Topic Subscriptions ##
  * `/seabee3/motor_cntl` ( [seabee3\_driver/MotorCntl](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/seabee3_driver/msg/MotorCntl.msg) ) - Sets `motor_driver[i]` to `motors[i]` if `mask[i]` is `1`

## Published Topics ##
  * `/seabee3/intl_pressure` ( [seabee3\_driver/Pressure](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/seabee3_driver/msg/Pressure.msg) ) - Internal pressure measured in [Montalbos](http://code.google.com/p/seabee3-ros-pkg/wiki/Montalbo)
  * `/seabee3/extl_pressure` ( [seabee3\_driver/Pressure](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/seabee3_driver/msg/Pressure.msg) ) - External pressure measured in [Montalbos](http://code.google.com/p/seabee3-ros-pkg/wiki/Montalbo)
  * `/seabee3/kill_switch` ( [seabee3\_driver/KillSwitch](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/seabee3_driver/msg/KillSwitch.msg) ) - Status of kill switch; 1=red, 0=green
  * `/seabee3/Dropper1Action` ( [seabee3\_driver\_base/FiringDeviceAction](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/seabee3_driver/srv/FiringDeviceAction.srv) ) - Send 0 to fire the device, 1 to reset
  * `/seabee3/Dropper2Action` ( [seabee3\_driver\_base/FiringDeviceAction](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/seabee3_driver/srv/FiringDeviceAction.srv) ) - Send 0 to fire the device, 1 to reset
  * `/seabee3/ShooterAction` ( [seabee3\_driver\_base/FiringDeviceAction](http://code.google.com/p/seabee3-ros-pkg/source/browse/trunk/seabee3_driver/srv/FiringDeviceAction.srv) ) - Send 0 to fire the device, 1 to reset