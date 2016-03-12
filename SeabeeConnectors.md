# Seabee New Endcap and Connector Project Page #

---

### Planned Endcap Layout ###
<img src='http://i.imgur.com/2qSB5xx.jpg' align='center' />
  * rendered mid-December.. some things have changed since.
  * Unshown thermosistor will be in middle, just below killswitch connector.  To be modeled soon - physical specs here (when i get to it.. its somewhere on the wiki too).
  * Currently, smaller-sized AWM (All-Wet M) connectors are depicted for power.  Will be replaced by larger AWO connectors.  (Yes, these will be massive, already implemented on CAD model.. just need to take a prettier picture).
  * Will upload technical drawings soon.

## O-ring stuff (updated 1/26!) ##
So currently figuring out o-ring gland dimensions/what o-ring to use.

[Parker O-ring Handbook](http://www.parker.com/literature/ORD%205700%20Parker_O-Ring_Handbook.pdf)

  * Looks like we'll stick to EPDM (see 3.14.4 in Parker Handbook)
  * in case you're curious.. SAE AS568 is the standard for o-ring sizes in US with their fancy dash #s.  Google for a table.
  * we'll probably be using either -366, -441, or -442.
  * O-ring gland dimensions are given from SAE AS5857 (aerospace standard for o-rings) as well as Parker's own industrial standard.  They differ by .02" - .03"
  * Parker's "standard" is in section 4, design table/graph/chart 4-2 (in the handbook)
  * AS5857 standard is in design table/graph/chart 4-1 (w/out tolerences  though)
  * Measured bore diameter of our current hull is 7.539"... which doesnt line up quite snuggly w/ any size for any standard =(
    * Option A:  Just deal with it and screw the tables and their tolerances. (and use table 4-2's -441 size... requires 7.5" ID for hull(w/ tol. +.002", -.000"))
    * Option B:  Bore out inner diameter of current hull to 7.625" (for Parker's req -366) or 7.724" (per AS5857 req for -442).. and ruin the inner anodization.
    * Option C:  Just get a new hull. starting from http://www.onlinemetals.com/merchant.cfm?pid=7084&step=4&showunits=inches&id=71&top_cat=60  and learn or get someone to weld mounting tabs on.. or use another clever method for attaching endcap.  And cut o-ring grooves to proper spec.

Random note:  face seals using o-rings in rectangular grooves are covered in the handbook - (section 4.3 in parker's handbook)

## Endcap Components ##
Endcap components will include pressure sensor, thermosistor, a whole bunch of wet pluggables, sacrificial anode, cooling plugs and schrader valve.  Mounting interface and other details of each component will be on this page.

### Connectors ###
| **Connector Series**| **# of pins**| **limiting AWG**| **Ampacity**| **Device**| **Qty**| **Datasheet**|
|:--------------------|:-------------|:----------------|:------------|:----------|:-------|:-------------|
|Seacon All-Wet Split M|2/12          |20               |7.0 A        |Motors     |2       |TBD           |
|Seacon All-Wet O     |3+GND         |8                |40.0 A       |Power/Battery Pods|3       |TBD           |
|Teledyne Micro Mini  |4             |20               |6.4 A        |USB Devices|5       |TBD           |
|Teledyne Micro Mini  |6             |20               |6.4 A        |Killswitch |1       |TBD           |
|Teledyne Mini        |7             |20               |5.6 A        |Sonar/DVL  |2       |TBD           |
|Custom Teledyne Micro Mini|8             |20               |5.6 A        |Ethernet   |1       |TBD           |

  * Power connectors are 3-pin+GND with pin 3 disconnected.  This is their lowest pin-count standard connector for the O (and M) size.  Even though we only need 2 pins.

  * 2/12 refers to 6 pie connectors, each containing 2 pins.. thus a total of 12 pins when pie is complete.  Sooo up to 12 2-pin cables/devices connected to these two split bulkhead receptacles.

  * in-line Ethernet connector will be 50 ft, twisted-pair terminated onto an RJ45 connector.

  * in-line main power connector is also 50 ft (8/2 SO AWG)

  * I'll grab links to datasheets soon.  (Though all are available at their official websites.)

### Schrader Valve ###
Need to find info.

### Thermosistor ###
Will fill out soon.  Info is somewhere on this wiki too

### Pressure Sensor ###

### Cooling Plugs ###