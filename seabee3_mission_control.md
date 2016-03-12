**Contents:**


# Introduction #

seabee3\_mission\_control uses all the available sensor data and high-level localization data to set navigation goals and control the state of the robot. For example, when starting the competition, Seabee needs to decide when it has passed through the gate and when it should start searching for buoys. In order to do this, it needs to know that it is transitioning from "pass through gate" state to "find buoy" state; it then needs to poll the landmark map to identify which direction buoys are in; it then finds the buoy of the right color and sets a navigation goal to be directly in front of that buoy (to hit it); it then sets another navigation goal behinds its current location (so it can see the other buoys) and finds the buoy of the next color.

# Usage #

## Compile ##

```
rosmake seabee3_mission_control
```

## Run ##

```
rosrun seabee3_mission_control seabee3_mission_control
```

# Documentation #
## Algorithm ##
  1. Start up
  1. Do something useful
  1. ???
  1. Profit.

## Usage ##
The state machine consists of a number of state objects within the machine.  Each of these should inherit from the main state class, which provides a number of methods which may be useful.

Each new state class should override four of the virtuals in the state class: init, entry, loop, and exit.  init() runs when the machine starts so that it can start any interfaces it may need.  entry() runs every time the state is entered and only once.  After that loop() is run repeatedly until changeState(int) is called, at which point it will change to the state passed as the argument.  exit() is run once during a transition from one state to another and has access to the member variable switch\_to, which should allow it to be aware of what state the machine is being changed to.

## Params ##
  * `<param name> [<param type> : <default value>]` - _info_

## Topic Subscriptions ##
  * `<topic name>` ( [topic\_message\_type](link_to_topic_message_type.md) ) - _info_

## Published Topics ##
  * `<topic name>` ( [topic\_message\_type](link_to_topic_message_type.md) ) - _info_