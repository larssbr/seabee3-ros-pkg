**Contents:**


# Fall 2012 Redesign Power Requirements #

**Update: I spoke with ADL and found out that their boards will draw approximately 13.4A at 100% CPU. This essentially means that all of the specs here need to undergo some major revision as the current system is completely insufficient to support a single ADL board, let alone two.**

### Batteries ###
Planned batteries for the new design are [here](https://code.google.com/p/seabee3-ros-pkg/wiki/Batteries#Planned_Battery_Upgrade).

## Master Power Requirements List ##
Incomplete.

| Components | Requirements |
|:-----------|:-------------|
| **Hieu's Summer 2012 Sonar Board** |              |
|ADCs        |+5V @ 3.5mA / ADC x 3 = 10.5mA total|
| Cheetah SPI | +5v @ 100mA over USB |
| Op-Amps    | +12V @ 6.35mA x 6, -12V @ 6.35mA x 6 = 76mA total |
| **Computing** |              |
| [ADLQM67PC-2715QE](http://www.adl-usa.com/products/cpu/datapage.php\?pid=ADLQM67PC-2715QE) | +5V @ ~3.0A avg, 10.0A peak x 2 = 6.0A avg, 20.0A peak |
| [Ethernet Switch](http://www.diamondsystems.com/products/epsilon) | +5V @ 1.08A  |
| **Actuators** | 6x Thrusters, Shooter, Dropper, Grabber |
| [12x Motor Driver ICs](http://code.google.com/p/seabee3-ros-pkg/wiki/PowerRequirements#Motor_Controllers) | +24V (battery direct) @ 5A x 12 = 60A |
| **Killswitch** |              |
| Logic      | +5v @ 100mA over USB |
| [Display](http://code.google.com/p/seabee3-ros-pkg/wiki/OnBoardLCDDisplay) | +5V @ 300mA over USB |
| **Sensors** |              |
| [4x Cameras](http://code.google.com/p/seabee3-ros-pkg/wiki/Cameras) | +5V @ < 200mA over USB x4 = 800mA |
| [Xsens Mti IMU](http://code.google.com/p/seabee3-ros-pkg/wiki/IMU) | +5V @ 70mA over USB|
| **[Doppler Velocity Log](https://code.google.com/p/seabee3-ros-pkg/wiki/DVL)** | +24VDC @  83mA avg., 500mA peak (Explorer model) |

## Conclusions ##

The power requirements for all of the devices listed as getting their power "over USB" can be factored into those of the computers. This places average computer current draw at 7.4A.

If we assume that the thrusters will typically be running at 100% (In reality, we usually run them around 20%), then with all thrusters on we will be drawing 30A at +24V. Assuming all six other actuators will be on at 100%, for 20% of the time of the thrusters (We actually run them infrequently enough for their effects to be negligible), then we will need to be able to support ~38A at 24V.

Note: Current power board (Congatec Conga-X945) draws ~2A.

**Totals:**
|+5V | ~8.4A |
|:---|:------|
|+12V | ~80mA |
| -12V | ~80mA |
| 24V | 38A   |

So each battery pod cable must be able to support about 47A.

# ATX #

The automotive power supply we are planning on using for the new power board is the [M3-ATX](http://www.mini-box.com/M3-ATX-DC-DC-ATX-Automotive-Computer-car-PC-Power-Supply). It has the following characteristics regarding power consumption.

**M3-ATX Characteristics:**

|Minimum Input Operating voltage| 6V|
|:------------------------------|:--|
|Maximum input Operating voltage|24V (clamping will occur at 25-27V)|
|Deep-Discharge shutdown threshold|11.2V|
|Input current limit (fuse protected)|15A|
|Max Output Power               |125 Watts (8-16V, see chart below)|
|Deep Sleep Current Consumption | < 0.5mA|
|Storage and operating temperature| -55  to +125 degrees C(storage), -40 – 65C (operating)|
|MTBF (Mean Time Between Failures)| 150,000 hrs @ 50C, 96,000 hrs @65C|
|Efficiency (Input 9-16V)       |94%, all rails combined, 50% load.|
|Input connectors               | Faston 0.25” terminal|
|Output Connector               | ATX Power 20 pin (Molex P/N 39-01-2200)|

Units starts failing at >125 Celsius. Operating at temperatures above 85C / 185F will drastically reduce the MTBF.

**Maximum Power Characteristics:**|Output Rail| Current(Max)| Current Peak(<30 seconds)|Regulation|
|:----------|:------------|:-------------------------|:---------|
|5V         |6A           |8A                        |1.5%      |
|3.3V       |6A           |8A                        |1.5%      |
|5VSB       |1.5A         |2A                        |1.5%      |
|-12V       |0.15A        |0.2A                      |10%       |
|12V        |4-6A (see below)|8A (see below)            |2%        |

When operating at <8V or >16V or extreme temperatures, de-rate by 25-50%, ventilation will be required.

**12V Rail Output Current**
|Input (V)| 12V out current|
|:--------|:---------------|
|6-8V     |4A, (6A peak)   |
|8-11V    |5A, (7A peak)   |
|11-16V   |6A, (8A peak)   |
|16-24V   |4A, (7A peak)   |

# Motor Controllers #
The proposed motor controllers for SeaBee are the MC33886 from freescale. At maximum capacity each will draw about 5 amps.

Data Sheet Link:
http://cache.freescale.com/files/analog/doc/data_sheet/MC33886.pdf