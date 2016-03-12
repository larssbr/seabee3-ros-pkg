# Introduction #

A Doppler Velocity Log is an advanced active sonar sensor that measures velocity in water by measuring the doppler effect on scattered sound waves. A DVL is super useful because it provides a high-certainty estimate of velocity (versus the acceleration measurement supplied by an IMU), which can be used to dead reckon the robot's position. Historically, the top five or so teams in RoboSub have used DVLs for most of their sensing. We may be getting one donated this year.

# Selection #

We are currently looking two models from Teledyne:
  * [Explorer](http://www.rdinstruments.com/pdfs/explorer_pa_ds_lr.pdf)
  * [Workhorse Navigator](http://www.rdinstruments.com/pdfs/wh_navigator_ds_hr.pdf)

The Workhorse Navigator has a full suite of sensors, whereas the Explorer is a barebones unit, and requires that we supply it with a heading measurement. However the Workhorse Navigator is an 8" by 8" cylinder that weighs 16kg and thus would be very difficult to implement on the mechanical side.

## Power ##
Despite probably not actually getting one of these things, we're leaving room for one on the power board. Here are the power requirements for the Workhorse Navigator, from the manual:

> The AC power adapter provided by TRDI is designed for testing where AC power is available. It provides up to 30 watts at 48 VDC. For deployments, the Navigator requires a power supply designed to supply between 20 to 50 VDC, 25 watts. Navigator power requirements are discussed below. Sonar performance depends on supply voltage, but not very strongly. The processing electronics use a DC/DC converter, so their function is independent of the supply voltage over the 20 to 50 volt range. However, the raw supply voltage is provided directly to the transmitter so that the transmitted acoustic power is proportional to Vin.

> NOTE. Transmitted power increases or decreases depending on the input voltage. Higher voltage to the DVL (within the voltage range of 20 to 50 VDC) will increase the transmitted power. The transmitted power is increased 6 DB if you double the input voltage from 24 VDC to 48 VDC. For a 300kHz Navigator, each additional DB will result in an increase in range of one default depth cell.


