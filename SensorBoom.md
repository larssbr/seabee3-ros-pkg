# Introduction #

In the 2013 Seabee frame design, the IMU, external pressure sensor, and external temperature sensor will be moved to a dedicated pressure case for the purpose of providing electrical isolation from the rest of the system.

**Question: Do we want to jam any other miscellaneous sensors in this case?** <br />
Two additional sensors can be soldered onto the board and fit inside the case at a later date if necessary.


# Mechanical Design #
An all-acrylic pressure case must be designed and fabricated.

## Mounting ##
Should be reasonably close to the sub's center of mass.

## Enclosure ##
All acrylic.

## Connectors ##
One 4 pin connector for USB, for the IMU. Another 4 pin connector for the SPI serial bus.

**Question: Should these be merged into one connector?**

At this time the connections will remain separate for ease of use.

# Electrical Design #
The main focus of this project will be to design an ADC board that will be located inside the sensor boom.

## ADC Board ##
In order to minimize noise, the pressure transducer and thermistor will be sampled on an ADC mounted inside the sensor boom. This ADC will send data to the GPIO board using a yet-to-be-determined serial interface.
  * Interfaces through ISP with Dynamic TDM
  * 4 channels in case more sensors will be added (Currently 2 will be used)
  * 12 bit resolution (4096 levels)
  * 27MHz speed

http://www.digikey.com/product-detail/en/ADS1174IPAPT/296-22951-1-ND/1770167

## Serial Interface ##

SPI Interface will be used as it is not limited to 8-bit words, has no limit on maximum clock speed vs. I^2C, and slightly lower power requirements at the cost of one extra pin.

[General Advantages/Disadvantages](http://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus#Advantages)



**Question: Should the board be round (concentric with the case) or rectangular?**

The board will be 2.5"x2.5" square to fit inside the case easily.

## Sensors ##
### IMU ###
The [Xsens MTi](http://code.google.com/p/seabee3-ros-pkg/wiki/IMU)

[Manual](http://wiki.icub.org/viki/images/8/82/XsensMtx.pdf)

Converted from RS232 to USB using: <br />
[FT232 to USB](http://www.digikey.com/product-detail/en/FT232RL-REEL/768-1007-1-ND/1836402) <br />
[FT232 Level Shifter](http://www.digikey.com/product-detail/en/SP213EHCA-L/1016-1019-5-ND/2410951)


### Pressure Transducer ###
http://www.meas-spec.com/product/t_product.aspx?id=5077

### Thermistor ###
We are looking at using a [US Sensor USP10981](http://www.digikey.com/product-detail/en/USP10981RA/615-1084-ND/2651602) to measure external temperature. This measurement can be used to make sonar calculations more accurate.

The range over which we hope to measure temperatures is 32 to 100 F

Designing an effective ADC: http://www.sensortips.com/temperature/designing-with-thermistors/

This Sensor corresponds with curve J : http://www.tetrix.com/jcurve.txt

Following this curve, the current thermistor should be placed in a voltage divider with a resistor of 9013.43 (rounded to 10k) ohms resistance