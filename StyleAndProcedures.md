**Contents:**


# Introduction #

This guide is meant to document the code style and general software practices that should be followed by the team at all times.

# Code Style #

The team uses a very slightly modified version of the [ROS C++ Style Guide](http://www.ros.org/wiki/CppStyleGuide)

# SVN #

## Working Directories ##

Since branching/merging/all that good shit can be a huge pain in the ass, team members should work off of the trunk, either committing only when there are no build errors, or adding a ROS\_NOBUILD file to the packages that have build errors.

## Committing ##

No auto-generated files should be committed to the SVN. Files that should be committed include:
  * `manifest.xml`
  * `Makefile`
  * `CMakeLists.txt`
  * `mainpage.dox`
  * `include/*`
  * `src/*.cpp`
  * `msg/*.msg`
  * `srv/*.srv`
  * `cfg/*.cfg`