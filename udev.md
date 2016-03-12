# Introduction #

**udev** is the device manager in our linux environment. We want to make sure that udev is set up properly so that we can connect to the necessary devices for seabee such as the cameras and the power board.


# Details #


We have a specific set of udev rules for the devices that our team uses. Let's find those rules.

  * Start by finding the udev folder inside of your seabee3-ros-pkg. This can be easily done by using roscd to access **seabee3\_common**. In case you need to review your ROS commands, refer to [ROS documentation ](http://ros.org/wiki/roscd).
> > `roscd seabee3_common`

  * Then find udev. And enter it, to find the rules.
> > `cd udev`


  * Hopefully you now see the file **01-seabee.rules**. Go ahead and open in in GEdit.
> > `gedit 01-seabee.rules`

  * Now, you should see something that looks like this:
> > |<img src='http://s20.postimage.org/rfj6t3d99/Screen_Shot_2013_01_23_at_11_57_30_PM.png'></img>|
|:---------------------------------------------------------------------------------------------|


  * As you can probably tell, this file is describing various attributes of the devices that we are connecting for seabee. In the image above, we can see that we have two identical Point Grey cameras. Their manufacturer and product ID are both the same, but their serial number is different. udev will attempt to match its attributes to the ones in these rules when a device is found, and if they match up according to the rules udev will then create each one a unique **symlink**.  If you want to find out more about writing rules for udev, check out the [Ubuntu manpage for udev](http://manpages.ubuntu.com/manpages/lucid/man7/udev.7.html)

  * Now, copy this rules file into the directory **/etc/udev/rules.d**. You can go check the directory to make sure the file has been copied afterwards.
> > ` cp 01-seabee.rules /etc/udev/rules.d`

  * Run the code below in terminal.
> > `sudo udevadm control --reload-rules`

