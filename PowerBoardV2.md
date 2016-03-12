![http://i.imgur.com/U782o.gif](http://i.imgur.com/U782o.gif)

![http://i.imgur.com/WOIPuZ6.png](http://i.imgur.com/WOIPuZ6.png)

![http://i.imgur.com/aSX4uN4.jpg](http://i.imgur.com/aSX4uN4.jpg)



# Things to Buy Next Time, _"GUYS"_ (1/20/2013) #
  * [AI-1433-TWT-R](http://www.digikey.com/product-detail/en/AI-1433-TWT-R/668-1341-ND/1745432) , audio buzzer
  * Clock batteries: [Sanyo CR2032](http://www.digikey.com/product-detail/en/CR2032/SY189-ND/1202936)
  * Clock battery holder: [TE Connectivity 120591-1](http://www.digikey.com/product-detail/en/120591-1/A99328-ND/289426)
  * Schottky diodes for power path: http://www.digikey.com/product-detail/en/MBR40250TG/MBR40250TGOS-ND/1477185
or http://www.digikey.com/product-detail/en/VBT4045BP-E3%2F4W/VBT4045BP-E3%2F4W-ND/3504651
  * 10 or so of these: http://www.nxp.com/products/automotive/discretes/general_purpose_transistors/pnp_transistors/PMBT3906.html#overview
  * 6 or so of http://www.digikey.com/product-detail/en/WSLP5931L3000FEB/WSLPD-.0003CT-ND/2695288 current sense resistors for batteries.
  * Some 12K SMD resistors (apparently we ordered 12 Ohm resistors last time by mistake)
  * Ribbon cable for making computer -> backplane cables
  * All of the Waho-hull connectors and associated contacts located [here](http://code.google.com/p/seabee3-ros-pkg/wiki/PowerBoardV2#Waho-Hull_Connectors)
  * Thermistor for hull, see [here](http://code.google.com/p/seabee3-ros-pkg/wiki/AnalogSensors#External_Temperature_Sensor).
  * New pressure transducer, TBD.
  * Mounting hardware (spacers etc.) associated with the power board system
  * Two op-amps, for aroma http://www.digikey.com/product-detail/en/AP358SG-13/AP358SGDICT-ND/1301715
  * 3 sets of two resistors one 10k and one 4.7k, all of them 0805.
  * Send off all of the power boards (waho, loko, motor, power, GPIO) to be fabricated.
  * Unit-test boards
    * Send off for fabrication.


# To Do List - FOR RIGHT NOW (1/17/13) #

**Pressure Transducer**
  * low pass filter ~ 100Hz


**Motor Driver Board:**


**Power Board**
  * Voltage Monitoring/ current sense prior to power path - (Voltage divider with high impedence)
  * Find schottky diode that can handle 30+ amps
    * Do we have a way of mitigating the issue with reverse leakage current they discuss
http://cds.linear.com/docs/LT%20Journal/LTC4412_Dec02_Mag.pdf
[here](http://en.wikipedia.org/wiki/Schottky_diode#Power_supply)? It would be an issue if we implemented the voltage and current monitoring for each battery for estimating state of charge - Dylan
    * HOW ABOUT THIS ONE http://www.digikey.com/product-detail/en/MBR40250TG/MBR40250TGOS-ND/1477185
    * Note: probably needs to be heatsinked
  * Find voltage regulator for uProcessor

  * Check 232 to USB - Copy Arduino Nuova for wiring diagram, leave JTAG 5V header floating.



**GPIO**
  * Finalize Layout with Rand and Brennan


  * Fix overlay and component labels
  * Fix FT232RL capacitors
  * Move Con1 and Con4 (UART1 and UART2) to dedicated header pins


**Back Plane**
  * Underwater reed switches
  * Bring system bus button signals (power and reset) to Waho board so that buttons can be added to endcap.
  * Add a header to break out the clock battery connections so that a pack-style clock battery can be used in place of the board-mount button cell if desired.
  * System Bus and buttons
  * figure out how to connect seaCon connectors to board
  * Select connector for system bus
    * Connector on the board is 98424-G52-18ALF. Mating connector is the FCI 90311-018LF. Digikey carries these but they are both non-stock. ~~We can buy these, but digikey estimates that they will ship on March 2 if ordered today (01/19/13).~~
    * Bought the mating connector from digikey. Estimated ship date is 2/25/2013.
    * Bought the board connector from mouser. Lead time is 6 weeks, which would place ship date on 03/02/13.
  * Find connectors to go between seaconn connectors and Waho.
  * Add holes for screws for the standoffs that will be holding the backplane onto the endcap. These holes should be proper through-holes with copper.

**Call 4PCB**
  * Ask 'em some questions. What if we go over your via requirement?
  * How fixed is that 30 in<sup>2</sup> requirement? What if I want like 32 in<sup>2</sup>?
  * Do you make the boards exactly to spec? or do you leave some extra?
  * What if I wanna make a 7x7 board? Am I hosed?
  * What if I want c colors? Deal with it.


# Overview #
The power board is split into three separate cards which plug into a back plane mounted on the same endcap as the connectors. The boards are:
  * Power Distribution
  * Motor Driver
  * GPIO

Some of you youngins may have gotten wind of our breakthrough new plan. We're gonna turn the power board into seperate boards and connect them via back plane. In turn this back plane will connect to the endcap of the hull so that we will be using almost no wires inside sea bee's hull. Fantastic? Ingenious? Yes yes we think so too. But to make this dream a reality, we're gonna need help from some friends, like Dog the Bounty hunter or Tyco Electronics and their magic murder bag. We're looking at the 5645235-3 from TE. its got 100 pads. Thoughts? Comments? Concerns? Then find your own damn connector and we'll use that one instead.

## Notes for Kanaloa Motor Driver Rev. 2 ##
  * Add back-EMF sensing for at least six motor channels.
  * Connect fault sense (FS) pins on the motor drivers to the microcontroller through a multiplexer

## Mezzzzanine Connectors ##
You guys ready to get your mezz on?! Then peep this: the backplane is actually going to be composed of two circuit boards. One will have the card edge connectors and interface with the motor controller and the other classic nintendo games,  and one will interface on the rad new connectors on the endcap. How will these boards interface with each other??? **_Mezzanine connectors_**. More specifically, the TE [5536272-4](http://www.digikey.com/product-detail/en/5536272-4/5536272-4-ND/1122036) (note that this has changed from the seemingly identical 536272-4 )and its ~~friend-with-benefits~~ female counterpart, the TE [5536279-4](http://www.te.com/catalog/pn/en/5536279-4). Where TE fails at not making their datasheets download automatically rather than opening in your browser, they succeed in making so many connectors that one of them happened to meet our crazy-ass power and signaling requirements. Each one of these babies has 100 signal pins that can supposedly carry almost 10A each (I think we should assume 3A for the sake of caution). They also have huge dedicated ground pins. The bottom line is that these things are going to be carrying current from board to board by the handful. We're going to use two pairs.

### Pictures ###
![http://www.te.com/catalog/common/images/PartImages/pr5536280-4.jpg](http://www.te.com/catalog/common/images/PartImages/pr5536280-4.jpg)

**536272-4**

![http://www.te.com/catalog/common/images/PartImages/pr5536279-4.jpg](http://www.te.com/catalog/common/images/PartImages/pr5536279-4.jpg)

**5536279-4**

### Current Ratings ###
![http://i.imgur.com/BMlva.png](http://i.imgur.com/BMlva.png)

## ATmega1280 ##
The Power Board is based around the ATmega1280 microcontroller. An independent ATmega1280 is used on each power board

### FT232 Interface ###
See [here](http://forums.adafruit.com/viewtopic.php?f=25&t=29807) for an explanation of how the DTR pin on the FT232RL is used to reset the Atmega 1280 in software.


# Power Path Controller #
Bad news kids, they shut down the Raytheon factory and daddy lost his job. Looks like we're not getting anything cool for Christmas this year. The old LTC4412 was only rated to 28 volts and couldn't quite muster the extra 1.5 volts to work with our big bully batteries, who are overcharged to around 29.5 volts. Furthermore, our current design has the girly-est transistors you ever did see, supporting a wimpy 1.8 volts. What's that you say? How will 1.8 volts support Seabee's new super death laser? They won't. Which is why we're getting serious with the SUDzor (SUD50P04-13L) SUD might stand for Super Utopian Dream, but probably not. What we do know is that the boys at Vishay's Siliconix department got down and dirty and punched out a surface mount transistor rated to 40 V volts and ready to sink just shy of 50 amps with out blinking an eye (largely due to the fact that the SUDzor has no eyes, but we're working on that. Also this thing will get pretty hot, which could be seen as a metaphorical eye blinking. We don't think so). Now, after extensive searching, we have found the bigger brother of the 4412, the LTC4412HV, from ~~Cinco~~ Linear Tech. They can handle 36 volts and work in the same way, switching the load via the SUDzors to which ever source (battery 1, 2 or wall source) is providing the highest voltage.


# Voltage Regulation #
Since we are no longer big fans of big honkin' ATX systems, we decided to try and find IC's with ludicrous current specs. These are the for runners, protectors of justice and the american Way.

**LMZ23610** _(aka BIG$$)_- These babies are just what we needed. Able to source roughly 10 A apiece from a small IC package, they can be chained together via a sick narsty share pin set up. 2 of them together will provide the necessary 20 amps of 5 volt current, and a third will be set to supply 3.3 Volts. Swaite.

**LMZ14203H** _(aka el primo retardo)_- The "retarded cousin" of the LMZ23610, who unlike his more handsome counterpart, can only provide 3 amps of current, will regulate the battery supply for a 12 volt source on the battery board.

**LTC3115-1** _(aka BrandNewKicks)_ - This hot item can take 24 volts and turn it into a big pizza pie - 24 VOLTS - haha YEAH! YOU KNOW WHAT I MEAN!? at any rate, as the battery discharges and its voltage decays, this bad mutha will keep the volts at 24. No questions asked.

# Battery Board Integration #

Some folks think we should keep our schools separate, but here at USC, we are all about equal opportunity for everyone in the community. That's why we want to bring the lonely battery board bros. to the power board. Since we didn't want to bring all the stuff and run a bunch of wires and what not all willy-nilly throughout seabee's innards, we decided that we should get a coulomb counter or something. Turns out there aren't a whole lot of these that don't want to talk to the individual LIPo cells. But alas, we found the perfect candidate:
**MAX 1660** _(aka The Sousa)_ - This guy does it all, and by it all, I mean count coulombs till judgement day. And store those counts, on its very own two of kind CHARGE and DISCHARGE counters.

_note: Turns out they don't make The Sousa anymore. Not to worry, since we will totally find a different chip made by maxim and name it The Sousa instead. The Sousa will rise again!_

# ADCs #
The ATmega1280 has a 10-bit, 16 channel ADC built in. Many of the ADC channels are used, especially on the motor driver board.
Notes:
  * AVCC is the supply voltage pin for Port F and the A/D Converter. It should be externally connected to VCC, even if the ADC is not used. If the ADC is used, it should be connected to VCC through a low-pass filter. This low-pass filter configuration is used on the power board.

# H-Bridges #
Using 12 [Freescale MC33886PVW](http://www.mouser.com/ProductDetail/Freescale-Semiconductor/MC33886PVW/?qs=sGAEpiMZZMvNQHCitdfR%252bD%252bkrSd7d5gQ) h-bridge motor controllers.

### Fault Status ###
The Fault Status (FS) pins on the motor drivers will be connected to the microcontroller through a 16-bit multiplexer, allowing all 12 motor drivers to be connected using only 5 I/O pins. A ROS node on the main computer will eventually be able to query the microcontroller for motor driver status, which will return the state of each FS pin.
Multiplexer: http://www.digikey.com/product-detail/en/SY10E164JZ/576-2498-ND/1032192



General info about designing with H-bridges: http://www.modularcircuits.com/blog/articles/old-h-bridge-secrets/part-1/

## Back EMF ##
Six of the twelve motor drivers will have back-emf sensing. This will be accomplished using the [MAX1238](http://datasheets.maximintegrated.com/en/ds/MAX1236-MAX1239M.pdf) (The Susman). The Max1238 is a 12-channel, 12-bit ADC. For each of these six motor drivers, the two motor outputs will be connected to the ADC. The ADC will be connected to the atmega using the I2C bus.

Back EMF, also known as counter electromotive force, is the voltage that is pushing against the current that induces it.  The motors create it because they act as generators when spinning, and we can measure the back emf to get an estimate of how fast our motor is spinning.  In order, to measure it all you need to use resistors to scale it down to an acceptable level for an adc and a h-bridge if the motor is going to run both directions.  Also, a latency period is needed between when the motor turns off and the back emf is at a stable, measurable level.
More Info: http://robidouille.wordpress.com/2009/09/20/back-emf/ http://www.acroname.com/robotics/info/articles/back-emf/back-emf.html

# General Board Specifics #
The Board is manufactured by our lovely friends, **Advanced Circuits**. They're cool, so don't question them. Because we don't question them, when they told us that our 4 layer board could be .062" thick we responded that .062 is a nice round and easy to remember number, and that it would work for us just fine. Board stackup is [here](http://www.4pcb.com/pcb-stack-ups-0.062.html). Note: In Altium, board layer thicknesses can be modified by visiting `Design >> Layer and Stack Manager` or pressing `Alt+D k` in PCB Document Editor mode.

![http://i.imgur.com/7IDrPBE.gif](http://i.imgur.com/7IDrPBE.gif)

# Waho-Hull Connectors #

|Signal|Board|Board-side Contacts|Mating|Wire Size|Mating Contacts|Rated Current|
|:-----|:----|:------------------|:-----|:--------|:--------------|:------------|
|Tether|[Molex Minifit Sr. 42820-2213](http://www.digikey.com/product-detail/en/42820-2213/WM6461-ND/459938)|Included           |[Molex Minifit Sr. 0428160212](http://www.digikey.com/product-detail/en/0428160212/WM1927-ND/283471) |8 AWG    |[Molex 42815-0032](http://www.digikey.com/product-detail/en/42815-0032/WM1949-ND/513214)|50A          |
|Battery 1|[Molex Minifit Sr. 42820-2213](http://www.digikey.com/product-detail/en/42820-2213/WM6461-ND/459938)|Included           |[Molex Minifit Sr. 0428160212](http://www.digikey.com/product-detail/en/0428160212/WM1927-ND/283471)|8 AWG    |[Molex 42815-0032](http://www.digikey.com/product-detail/en/42815-0032/WM1949-ND/513214)|50A          |
|Battery 2 |[Molex Minifit Sr. 42820-2213](http://www.digikey.com/product-detail/en/42820-2213/WM6461-ND/459938)|Included           |[Molex Minifit Sr. 0428160212](http://www.digikey.com/product-detail/en/0428160212/WM1927-ND/283471)|8 AWG    |[Molex 42815-0032](http://www.digikey.com/product-detail/en/42815-0032/WM1949-ND/513214)|50A          |
| Motors 1-6 | [Molex MLX 10-84-4120](http://www.digikey.com/product-detail/en/10-84-4120/WM1261-ND/134543) | Included          | [Molex MLX 50-84-1120](http://www.digikey.com/product-detail/en/50-84-1120/WM1252-ND/134555) | 20 AWG  | [Molex 0002081003](http://www.digikey.com/product-detail/en/0002081003/WM2291CT-ND/2405640) |12A          |
| Motors 7-12 | [Molex MLX 10-84-4120](http://www.digikey.com/product-detail/en/10-84-4120/WM1261-ND/134543) | Included          | [Molex MLX 50-84-1120](http://www.digikey.com/product-detail/en/50-84-1120/WM1252-ND/134555) | 20 AWG  | [Molex 0002081003](http://www.digikey.com/product-detail/en/0002081003/WM2291CT-ND/2405640) |12A          |


http://www.digikey.com/product-detail/en/0039291128/WM3905-ND/61437
tapping screw m3


![http://i224.photobucket.com/albums/dd153/Garcya85/KANALOA-Converted.jpg](http://i224.photobucket.com/albums/dd153/Garcya85/KANALOA-Converted.jpg)