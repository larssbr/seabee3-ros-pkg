**Contents:**


# Introduction #
This project is a simulator for the USC Competitive Robotics Team. It is meant to run on Ubuntu 9.04 Linux, but should run on other distributions. Eventually this project will allow us to test our control and vision algorithms without physically testing the vehicle in a pool.

# Proposed Changes #
This node is being revised. The proposed changes are described below on a per-user basis:

## Dhruv Monga ##

  * General overview:
  * Required research: Look into how to develop simulators using Perl.
  * Algorithm:
    1. Start up
    1. Do something useful
    1. ???
    1. expand on this idea of ???
    1. Come up with a nifty logo for ???
    1. package ??? with sub prime mortgages
    1. sell these bundles under the new name ?!!
    1. Pick on new home owners by offering them loans backed by the capital from ?!!
    1. wait.
    1. watch the world burn.
    1. Profit.

## Sagar Pandya ##

  * General overview: This project consists of two parts: Physics model, and Simulator. The Simulator will place a virtual SeaBee in an aquatic environment and run our ROS algorithms to generate movement commands. Then the Simulator will consult the Physics model to determine how SeaBee would realistically move. The ideal simulation environment will contain all the objects we need to interact with: buoys, colored rectangles, tool boxes, etc. The Simulator output would ideally be a rosbag file containing sequences of images from the simulated SeaBee cameras and other simulated sensor data. The Simulator will run on a server which will keep an up-to-date copy of SeaBee's code and run the simulation every night.
  * Required research:
    1. OGRE usage
  * Algorithm (below will run every night as a cron job):
    1. SVN update and compile ROS code
    1. Initialize Physics model and Simulator
    1. Run SeaBee's code and apply movement commands to virtual SeaBee
    1. Record rosbag file
    1. End simulation once goal state is reached
    1. Log all output messages and email status to software team

# Current Implementation #
Currently SeaBee is simulated using OGRE and Hydrax in a static (physics free) environment.


---


# Dependencies #
  * The beosub svn repository (different from the google code one) at svn://isvn.usc.edu/hardware/beosub/trunk/AUV\_Simulator
  * Ogre Version 1.6.4
  * Hydrax Version 0.4
  * A recent release of OIS
  * A recent release of OpenGL

# Installation #

## Install Ogre ##

There is a very good tutorial for installing OGRE at http://ubuntuforums.org/archive/index.php/t-1144592.html You can stop following the instructions after step 1.9


## Install Hydrax ##

This can be very tricky. You can install Hydrax 0.5.1 manually, however, you have to compile the shared library manually, the source is written for windows so there are tons of things that need to be changed that you need to figure out, and there is no linux project for it. Its frustrating, but if you really want the new Hydrax its not that bad.

An easier alternative is to use Hydrax 0.4. Luckily, the difference for underwater effects is not all that great and there is a linux project available to download it at http://firecool.interfree.it/Hydrax-v0.4-linux.tar.bz2 You can then install it by doing the following. First 'untar' the source by going to the same directory that it is in and typing:
```
tar -xjvf Hydrax-v0.4-linux.tar.bz2
cd Hydrax-v0.4-linux.tar.bz2
cmake -G "Unix Makefiles"
make
```

Next, move the libHydrax.so file to /usr/lib/libHydrax.so
Then, move Demo/include/Hydrax to /usr/local/include/Hydrax


## Install Codeblocks ##

This simulator has been set up as a codeblocks project. You can also compile it with make, eclipse, etc, but there is already a codeblocks project setup! After you have codeblocks installed, open the file called AUV\_Simulator.cbp, and the project will be opened up.


## Setting up the Environment ##

The project requires the following libraries, which should be in the following locations. To change these library paths, open the codeblocks project and go to Project->Build options, click on the "Linker Settings" tab, then make sure that AUV\_Simulator is highlighted on the left side, and not Debug or Release.
  * /usr/local/lib/libOgreMain.so
  * /usr/local/lib/libOIS.so
  * /usr/lib/libHydrax.so
  * /usr/lib/libGL.so
  * /usr/lib/libCgGL.so

The project requires the following search directories. To edit these, go to Project->Build options, click on the "Search directories" tab, and then make sure that AUV\_Simulator is highlighted on the left side, and not Debug or Release. You will need to change the search directory for the include directory to wherever you installed OGRE
  * /home/john/.ogre/Samples/Common/include (needs to be changed for your system!)
  * /usr/local/include/OGRE
  * /usr/local/include/Hydrax


## Resources ##

For ogre to run, you need to tell it where to find the resources it will need. These are specified in the "resources.cfg" file that is in the same directory as the executable - AUV\_Simulator/bin/Debug/resources.cfg. You will need to change the paths of all of these locations to fit wherever it is on your system. Sometimes relative paths don't work so I have found it easiest to use absolute paths. (if your using vim find and replace, you need to put a \ before each / in the search and replace command)


## Plugins ##

In the same directory as the executable and the resources.cfg file is a file called plugins.cfg. This needs to be edited if you will be using different software. For example, if you wanted to run this on windows and use DirectX instead of OpenGL, you would need to change the 3D renderer in this file.


# Usage #

Click on the yellow gear in the codeblocks window to build the project, or the Blue arrows to clean and rebuild it. Unfortunately, you cannot run the project through codeblocks, clicking on the Green Arrow will only give an error. So to run the simulator, you must open up a terminal, go to AUV\_Simulator/bin/Debug and then run the following command:
```
./AUV_Simulator
```

A box will pop up, make sure you select the "OpenGL Rendering Subsystem", click accept, and then the simulator should run.

# Editing #

## Debugging ##

Most debugging problems can be solved by taking a look at the Ogre.log file that is in the same directory as the executable - AUV\_Simulator/bin/Debug/Ogre.log. Scroll down till you find the first error, then copy + paste + google.

In addition, the API documentation is very good. There is no longer documentation for version 0.4 of Hydrax, but most of the functions are the same as the 0.5 version that can be found at: http://modclub.rigsofrods.com/xavi/05APIDoc/html/


## Files to Edit ##

Below are the main files that can be edited in order to change the simulator.

Main:
  * AUV\_Simulator/src/main.cpp
Water Effects:
  * AUV\_Simulator/Media/Hydrax/Hydrax.hdx
Terrain:
  * AUV\_Simulator/Media/materials/scripts/Terrain.cfg
  * AUV\_Simulator/Media/materials/scripts/Terrain.material
Plugins:
  * AUV\_Simulator/bin/Debug/plugins.cfg
Resources:
  * AUV\_Simulator/bin/Debug/resources.cfg


## Terrain Parameters ##

The terrain (the ground that surrounds the water) was built using the 'Terragen' software. Unfortunately, it doesn't run on linux, so the terrain heightmap must be built on mac or windows. The output from this program is the terrain.raw heightmap that is in AUV\_Simulator/Media/materials/scripts. The Terrain.material file controls the textures that are then applied to this heightmap. You can change the textures applied by adding new images to Media/materials/textures and then adding a new function to Terrain.material. In addition, ogre requires a .cfg file for the TerrainSceneManager, which is the Terrain.cfg file in Media/materials/scripts. Lastly, it is important to apply the hydrax depth technique to the terrain, which can be seen in the cpp source.


## Water Parameters ##

The parameters for the water can be easily changed in the Hydrax.hdx file in AUV\_Simulator/Media/Hydrax. It is pretty self explanitory, and parameters such as foam, fog, waves, reflections, god rays, depth, etc can all be changed. To easily see how to change these and then export a completed .hdx configuration file, download the precompiled Hydrax Editor, which only works on windows, and then use the .hdx file saved from that in this project.