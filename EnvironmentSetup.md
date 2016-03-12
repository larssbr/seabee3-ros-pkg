**Contents:**


# Introduction #

This tutorial will guide you through the setup of Eclipse, Subclipse, and will explain how to set up the auto-formatter in Eclipse to match the team's style guide.

# Procedure #

  1. Install eclipse classic: `sudo apt-get install eclipse`
  1. Install Subclipse and CDT
    1. Open eclipse
    1. Go to `Help->install new software`
      1. Mark Eclipse C/C++ Development Tools for installation
        1. Select `Galileo update site->programming languages`
        1. Check `Eclipse C/C++ Development Tools`
      1. Mark Subclipse for installation
        1. Paste the following URL into the `Work with` dropdown: `http://subclipse.tigris.org/update_1.6.x`
        1. Check all available items for Subclipse
      1. Click 'apply' and follow the wizard
      1. Restart eclipse
    1. Go to `Window->Preferences->Team->SVN`
    1. Change `SVN Interface` to `SVNKit`
  1. Check out seabee3-ros-pkg as an eclipse project
    1. Go to `File->New->Other...->SVN->Checkout projects from SVN`
    1. Create new repository location: `https://seabee3-ros-pkg.googlecode.com/svn/trunk/cturtle/`
    1. Accept default options
  1. Configure the auto-formatter and default code templates
    1. Configure the auto-formatter
      1. Go to `Window->Preferences->C/C++->Code Style->Import..`
      1. Browse to `~/workspace/seabee3-ros-pkg/software-docs/ros-standard-eclipse-formatter.xml`
      1. Click apply; from now on, if you select one or more lines of code and press `Ctrl+Shfit+F`, the code will be auto-formatted according to the team's style guide. The usual procedure is to select all the code (`Ctrl+a`) and then auto-format.
    1. Configure default code templates
      1. Go to Code Templates (`Window->Preferences->C/C++->Code Style->Code Templates`)
      1. Click import
      1. Browse to `~/workspace/seabee3-ros-pkg/software-docs/eclipse_codetemplates.xml`
      1. Click apply; from now on, when you create a new C/C++ header, source file, or class, the appropriate license file (with your user name and the current date) will be placed at the top of the page for you.