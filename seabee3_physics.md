**Contents:**


# Introduction #

seabee3\_physics is a physics simulator for the submarine which uses the Bullet physics library to simulate the effects of thruster commands, hydrodynamic forces, friction, and gravity on the craft.

# Usage #

## Compile ##

```
rosmake seabee3_physics --rosdep-install
```

## Run ##

**Note:** While seabee3\_physics can be run on its own, it looks for external transforms on startup. The node will not crash, but will operate incorrectly. A launch file has been created to publish these transforms and ten start up seabee3\_physics, ensuring that the node will operate as intended. The preferred start-up method is to execute roslaunch on this launch file.

```
roslaunch seabee3_launch seabee3_physics.launch
```

## Test ##

See [SimulationTesting](SimulationTesting.md)


# Documentation #


## Params ##


## Topic Subscriptions ##
  * `tf:<robot_frame>-><thruster_frame>` - A transform from the center of the robot to each of the thrusters
  * `/seabee3/motor_cntl`


## Published Topics ##
  * `tf:<world_frame>-><simulated_robot_frame>` - A transform from the world origin to our best guess of the robot's current position using the physics simulation