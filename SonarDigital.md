**Contents:**


# Introduction #

The primary function of the digital board at the moment is a that of a programmable oscillator that will provide a clock signal to the switched capacitor filter on the analog board. This will allow us to set the bandpass frequency from software, so that we can easily filter out all frequencies except that of the [pinger](http://code.google.com/p/seabee3-ros-pkg/wiki/sonar_passive#Past_Objective_Information) on the day of the competition.


# Details #



---

![https://lh6.googleusercontent.com/-rtSRypUrXf8/TmIO6UT68KI/AAAAAAAAAAk/04iwRj33JCE/arduino_uno_test.jpg](https://lh6.googleusercontent.com/-rtSRypUrXf8/TmIO6UT68KI/AAAAAAAAAAk/04iwRj33JCE/arduino_uno_test.jpg)
## Microcontroller ##
  * Arduino
  * Might be overkill if the digital board ends up being only used to provide a clock signal, but will make things easy during prototyping phase
  * Signal path: Carrier Board >> Arduino >> Progammable Oscillator >> Switched Capacitor Filter


## Programmable Oscillator ##
  * Looking at Maxim [DS1077](http://pdfserv.maxim-ic.com/en/ds/DS1077.pdf) and [DS1085](http://datasheets.maxim-ic.com/en/ds/DS1085.pdf).
  * Samples of DS1077Z-100 and DS1085Z-10 ordered from Maxim as of 09/03/11 for use in test bed oscillator design
  * Interface with Arduino through I2C serial interface
  * The switched capacitor needs to be able to filter a narrow frequency between 20 KHz and 40 KHz. Most of the switched capacitors we have been researching are controlled by a clock frequency in the 0-40 MHz range
  * The DS1085Z-10 has a master clock frequency range of 66-133 MHz, adjustable over the I2C connection in 10 KHz intervals. This is fed into a programmable divisor of 1-1025, making for a wide range of available output values.
  * The Maxim ICs are in the 8 pin SOIC package. I ordered breakout boards for the testbed phase.