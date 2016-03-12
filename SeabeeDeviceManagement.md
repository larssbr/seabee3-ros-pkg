# Introduction #

In order to ensure that Seabee's USB devices always show up in the same /dev file, you need to make a udev rule for each device.

# Details #

All of our udev rules are in /etc/udev/rules.d/01-seabee.rules

Please prefix each device with "seabee