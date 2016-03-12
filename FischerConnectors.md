# Introduction #
Seabee currently uses [Fischer Connectors](http://www.fischerconnectors.com/) exclusively for aquatic connectors. These connectors are scheduled to be completely replaced by SeaConn and SubConn brand connectors, due to their general lack of reliability and high cost. In the meantime, efforts are being made to bring the current connectors up to working condition.

# Maintenance #

## Week of 11//27/12 - Wet Test Prep. ##
All of the Fischer connectors and USB cables are in a box on top of one of the beige shelves in the electrical room. We should get some silver sharpies so that we can mark the place where we will be stripping the cables, then experiment to find the optimal length for the stripped cables.

### USB ###
  * Available cabling is 8-conductor (4 twisted pairs) cable found on the floor of the software lounge.
  * Made one new cable
    * Labeled "New 1"
    * Needs to be tested.

### Power Tether ###
  * Connector sheathe is missing. This isn't a problem because we have plenty of extra sheathes.
  * Tons of corrosion at the point where the cable is soldered to the connector. Water was clearly leaking into this area. It's not clear if it was leaking through the front or the back of the connector. Wires are melting and conductors are super oxidized.
  * We don't seem to have any extra replacements for the conductor portion of the connector, so we need to see if this one can be salvaged.
  * O-ring is fucked
  * Works electrically, but won't seal
  * Solved by potting the connector with RTV.
### Fischer to USB ###
  * Multiple solder joints were broken in the connector. They were inside heat shrink, meaning that were still connected, but would lose connection intermittently.
  * Resoldered all four pins and used heat shrink.
  * Passes the shake test now
  * Labeled "USB 1"

### Camera and IMU Pods ###
  * Camera 1
    * Power and ground joints on the receptacle for camera 1 (forward facing, left) were broken. Resoldered and it works fine now.
    * Added cap for receptacle
  * Camera 2
    * Pin broke off of internal USB receptacle.
    * Replaced internal USB receptacle.
    * Added second mounting screw for camera.
    * Added shim to correct camera pitch
  * IMU
    * 1 joint on receptacle and 1 joint on USB plug were broken. All of the connections on the receptacle had loose strands of wire.
    * Receptacle is badly corroded
    * Replaced receptacle
    * Added cap