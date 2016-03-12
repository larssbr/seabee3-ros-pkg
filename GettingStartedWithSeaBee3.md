**Contents:**


# Introduction #
This is a quick guide for installing the prerequisites to seabee3-ros-pkg and compiling the components contained in the package.


# Details #
Seabee3-ros-pkg is designed for use with [ROS](http://ros.org). It contains drivers for USC's custom-built autonomous underwater vehicle, SeaBeeIII, as well as drivers for the sub's sensors. This package is built and tested under Ubuntu >= 10.04 amd64; however, the code is architecture-independent. Furthermore, pre-compiled shared libraries which are architecture-dependent are compiled for i386 and x64 and the makefiles for these libraries should be able to recognize the architecture in use and proceed accordingly.

# Prerequisites #
## Ubuntu ##
  * Ubuntu is a free, open-source operating system utilizing the Linux kernel. It features frequent updates and good support.
  * To get the latest version of Ubuntu, head over to [http://ubuntu.com](http://ubuntu.com).
  * If you don't want to perform a native installation of Ubuntu, we recommend using VirtualBox to perform a virtual install of Ubuntu inside of an existing Windows or OSX installation

## ROS ##
  * ROS is a free, open-source toolkit with general interfaces for creating specific software implementations with applications in robotics. It is full of utilities and is well-documented.
  * seabee3-ros-pkg has recently adopted ROS diamondback as its default environment. ROS cturtle is no longer supported.
  * the correct version of ROS will automatically be downloaded when the installation script is invoked (see Installation below)

# Installation #
  * An [installation script](http://seabee3-ros-pkg.googlecode.com/svn/trunk/diamondback/install.sh) has been created to automate the installation of all files used by this project.
  * Make sure you have wget:
```
sudo apt-get update && sudo apt-get install wget
```
  * Now download and run the install script:
```
wget http://seabee3-ros-pkg.googlecode.com/svn/trunk/diamondback/install.sh -O ~/seabee3-install.sh && bash ~/seabee3-install.sh
```

# ToDo #
  * _soon: graph of seabee3-ros-pkg component, publisher, subscriber, server, client, service, and message structure/dependencies_
  * _soon: launch file explanation_
  * _soon: ssh instructions, manual launch instructions_