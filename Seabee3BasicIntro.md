
---

![http://i.imgur.com/PGv2V.jpg](http://i.imgur.com/PGv2V.jpg)

---

# Introduction #

SeaBee III is an <b>A</b>utonomous <b>U</b>nderwater <b>V</b>ehicle (AUV) built by (mostly) undergraduate students at the University of Southern California.  By "autonomous," we mean that SeaBee III is capable of navigating small underwater environments all by itself, with absolutely no intervention from the outside world. That means no remote control, no GPS, etc. We hit the start button, and it goes off and does [it's thing](ProjectIntro.md).

The SeaBee project began around 9 years ago when a group of undergraduates wanted to participate in the Association for Unmanned Vehicle System International (AUVSI) AUV competition. The competition, now going into its 15th year, is basically an underwater obstacle course to be traversed completely autonomously by each team's robotic submarine. Tasks in the competition consist of:

-Going through a starting gate
-Hitting 2 out of 3 buoys (Ex: there is a red, green and yellow buoy, you must hit the red and green buoys)
-Dropping markers into the bins with certain pictures in them (Ex: 4 bins each with a picture of a heart, diamond, club, or spade, you have to drop the marker in the heart and club bin)
-Shooting a projectile through a window
-Locating, picking up, and surfacing with a 20-30kHz pinger

At the highest level, our approach to the competition is about three main aspects of robotics: controls, localization, and computer vision.

Controls is an area of engineering broadly centered around ensuring devices will consistently perform in a desired manner even in a noisy environment. For example with SeaBee when we tell the robot to go in a straight for 10 meters, we hope that it will actually do that. The difficulty lies in the fact that not all of the thrusters are identical, there may be currents in the water, etc. A good control system hinges upon reliable sensor data and fast error-correcting algorithms.

Localization is based around the problem of assessing where you are in your environment. With terrestrial and aerial robots this can be as simple as using GPS, depending on how much accuracy you need. The issue with the competition environment is that, because you can see very few objects underwater unless they are very close and the use of GPS is impossible, localization can be an incredibly difficult task. Our localization is current based largely on a physics model of the robot combined with compass, accelerometer, and pressure data from our sensors.

Computer vision is one of the most complex tasks in robotics. While it seems natural for humans to perceive their environments, actually understanding what objects in an image mean from first principles can be astoundingly difficult. While it may be somewhat simple to write an algorithm that will pull out the information you want, it is hard to ensure that it only finds what you are looking for and no false positives. For instance, if SeaBee is looking for a buoy and it sees a blob on the wall of the pool that is the right size and shape it could easily register that as its target and drive right into the wall. Conversely the algorithms must be able to find what you are looking for from any angle, so that if you see a target from a side view there must be some way to transform the image into a known image and identify it. If you can only recognize an object when you are facing it dead on, you may have to rely on getting lucky or you could miss it entirely. The trick is to create extremely robust algorithms that find the essential features of what you are interested in and consistently find only them in a given image. This can be done by passing an image through a vision pipeline which does several steps of processing to make it as easy as possible for the high level algorithms to simply match objects against known templates and determine if the observed target is the one we are interested in finding.

Robots are built from the ground up. If the mechanical design is flawed then there is only so much that the electrical and software systems can do to compensate. Similarly if there are electrical limitations then software can only do so much. The key is a holistic approach that takes into account every level from the earliest stages of design so that bottlenecks don't occur when it is too far down the line to fix anything. While some tasks may seem trivial, it takes an incredible amount of work even to do a task as simple as driving in a straight through a gate. SeaBee has come a long way since the first model about a decade ago and we are in a state of constant revision to ensure it can do absolutely everything that could possibly be asked of it.