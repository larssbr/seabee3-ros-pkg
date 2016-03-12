

# Introduction #

This page describes some of the analog sensors used on Seabee. All of the sensors are measured using the ADCs on the [GPIO board](http://code.google.com/p/seabee3-ros-pkg/wiki/PowerBoardV2).

# Sampling on the Atmega 1280 #
The analog sensors on the GPIO board will be sampled using the Atmega 1280's built-in ADCs. The ADCs have a 10-bit depth and can theoretically be sampled at 15kS/s at this bit depth. To actually hit this speed we would need to use interrupts and not built-in Arduino functions like analogRead(). The Atmega 1280 has 8 kB of SRAM, so in theory, i.e., if no other variables are being used, 6400 samples can be stored and processed in-place at this bit depth.

# Internal Pressure Sensor #
[Honeywell ASDXACX030PAAA5](http://www.mouser.com/Search/ProductDetail.aspx?qs=pWfxi%252bnaNCd%2FlCoZwgBczA%3D%3D)

On the power board.

**Question: Why are we using this model?**

**Answer: Time to do some research.**

# External Pressure Sensor #
[Measurement Specialties Inc. US331-000005-015PG](http://www.digikey.com/product-detail/en/US331-000005-015PG/356-1044-ND/735337)

~~Mounted to the hull on the same end as the Fischer connectors.~~


Mounted in the [Sensor Boom](http://code.google.com/p/seabee3-ros-pkg/wiki/SensorBoom)

Some facts:
  * Gauge pressure sensor. It measures pressure relative to atmosphere (calibrated at the manufacturer's facility I think).
  * Range is atmosphere to atmosphere + 15psi
  * The accuracy of the model is listed as +/- 0.15%span, so +/- 0.0225 psi.
  * If we sample using the Atmega 1280 (10 bits), the quantization error is about 0.01464 psi.
  * There are 1.4206 psi/meter in fresh water (like the competition pool), so the max depth for the transducer is 10.55 m. This is a little less than the deepest part of the competition pool (11.58 m). It would be nice if the functional range was a little better than that, but since the error psi scales with range, this is actually pretty optimal.
  * This also means that the error on the pressure transducer is going to be at least  0.01583 m, or 0.0519 ft, or 0.62 inches.
  * Costs $133.35
  * Cornell uses one too. Probably not too much though since they have the whole DVL thing going and that gives altitude.

# External Temperature Sensor #

Mounted in the [Sensor Boom](http://code.google.com/p/seabee3-ros-pkg/wiki/SensorBoom)

We are looking at using a [US Sensor USP10981](http://www.digikey.com/product-detail/en/USP10981RA/615-1084-ND/2651602) to measure external temperature. This measurement can be used to make sonar calculations more accurate.

The range over which we hope to measure temperatures is 32 to 100 F

Designing an effective ADC: http://www.sensortips.com/temperature/designing-with-thermistors/

This Sensor corresponds with curve J : http://www.tetrix.com/jcurve.txt

Following this curve, the current thermistor should be placed in parallel with a resistor of 9013.43 ohms resistance