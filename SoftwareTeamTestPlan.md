#Outline and ideas for what could be tested on Seabee

**Contents:**


# Introduction #

This page outlines the different software components that need to have automated tests created for them. The final goal is to have an automated system that runs the tests every night and sends out a notification for failed tests.

# Image Processing #
Each of these tests should take in a set of images and output the results of the image recognition test. Specifically, it should compare the image recognizer's result with some known result that has been manually determined from the input image. Then the test will rank the recognizer based on percent difference, or absolute difference, or some other metric.

### Color Classifier ###
Test input will be small images that have distinct regions (e.g. colored squares) Each test image will have a corresponding text file that states the exact location of each colored block. The inputs will also be overly saturated and contain multiple shapes to determine the robustness of the color classifier. Results will contain the percent difference between the determined solution and the output of the color classifier.

A directory that contains pre-colored images will be used to compare against the output of the color classifier. These will be names according to picture id and color. The test program will then parse these images into a bag file of ComponentImageArray messages. This will be compared against a bag of ComponentImageArray messages taken from the output of color\_classifier

### Simulator ###
Real data from the wet tests should be compared with the results we get from the simulator. We could measure the distance the robot moves in water by laying a laminated set of contrasting tiles on the ground and using a camera to measure distance.

### Buoy Recognizer ###

### Hedge Recognizer ###

### Bin Recognizer ###

### Gate Recognizer ###

### Window Recognizer ###


# Movement and Localization #

### PID Test ###

# Sensors #
It might be useful to have a tool that takes in all sensor input and graphs the results over time.