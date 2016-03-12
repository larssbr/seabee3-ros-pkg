# Introduction #

Current plan is to get ~~two~~ one (turns out they cost like $2000, we don't actually need the extra computing power that badly and heat is a concern) ADL Embedded Solutions [ADLQM67PC-2715QE](http://www.adl-usa.com/products/cpu/datapage.php\?pid=ADLQM67PC-2715QE). ~~The boards will be networked using an [ethernet switch](http://code.google.com/p/seabee3-ros-pkg/wiki/EthernetSwitch)~~

These boards are spec'd to use 67W at 100% CPU, which means 13.4A at 5V.

Each board has 10 USB ports. 8 are standalone. The other two are on the PCI104 bus and are prohibitively difficult to break out.

![http://i.imgur.com/nduvQ59.png](http://i.imgur.com/nduvQ59.png)

## Connectors ##
![http://i49.tinypic.com/v5x3zl.png](http://i49.tinypic.com/v5x3zl.png)

<sup>+</sup>This diagram is out of date and does not describe all connectors used.

Connectors that will be used on SeaBee are labeled.

The connector models are as follows:
| Bus/Signal | Connector on board | Mating connector |
|:-----------|:-------------------|:-----------------|
| Power      | [Molex PS 43045-1021](http://www.digikey.com/product-detail/en/0430451021/WM2676-ND/1635027) | [Molex PS 43025-1000](http://www.digikey.com/product-detail/en/0430251000/WM1787-ND/252500) |
| USB 1-4    | [FCI 98424-G52-16ALF](http://www.digikey.com/product-detail/en/98424-G52-16ALF/609-2652-6-ND/1887914)| [FCI 90311-016LF](http://www.digikey.com/scripts/DkSearch/dksus.dll?WT.z_header=search_go&lang=en&keywords=FCI%2090311-016LF&x=0&y=0&cur=USD) |
| USB 5-8    | [FCI 98424-G52-16ALF](http://www.digikey.com/product-detail/en/98424-G52-16ALF/609-2652-6-ND/1887914) | [FCI 90311-016LF](http://www.digikey.com/scripts/DkSearch/dksus.dll?WT.z_header=search_go&lang=en&keywords=FCI%2090311-016LF&x=0&y=0&cur=USD)  |
| RS-232 1   | [FCI 98424-G52-10LF](http://www.digikey.com/product-detail/en/98424-G52-10ALF/609-2648-1-ND/1090299) | [FCI 90311-010LF](http://www.digikey.com/product-detail/en/90311-010LF/609-2772-ND/1090031) |
| RS-232 2   | [FCI 98424-G52-10LF](http://www.digikey.com/product-detail/en/98424-G52-10ALF/609-2648-1-ND/1090299) | [FCI 90311-010LF](http://www.digikey.com/product-detail/en/90311-010LF/609-2772-ND/1090031) |
| Ethernet   | [FCI 98424-G52-12ALF](http://www.digikey.com/product-detail/en/98424-G52-12ALF/609-2642-1-ND/1090300) | [FCI 90311-012LF](http://www.digikey.com/product-detail/en/90311-012LF/609-2797-ND/1090013) |
| System Bus<sup>+</sup> | [FCI 98424-G52-18ALF](http://www.mouser.com/ProductDetail/FCI/98424-G52-18ALF/?qs=sGAEpiMZZMvmMeM28A2o4O6NgF7GypBK)| [FCI 90311-018LF](http://www.digikey.com/product-detail/en/90311-018LF/609-2789-ND/1090050) |

**<sup>+</sup>Nobody stocks this 18-pin version of the connector, so it has huge lead times associated with it.**

**<sup>++</sup> 3D model lookup for FCI connectors is [here](http://portal.fciconnect.com/portal/page/portal/fciconnect/producttype?appname=FCIDocumentFileSearch$DocType=ThreeDModel)**

## System Bus ##
![http://i.imgur.com/PzD6q.png](http://i.imgur.com/PzD6q.png)

### PSON ###
Should be connected to an I/O pin on the power board (i Ka Holo Nui). This can be used to alert the power supply that the computer is overheating and should be shut off.

### Reset and Power ###
Each signal needs to be connected to its own pushbutton located on the backplane. The signals are active low, so the pushbutton must make contact with ground when depressed. These should be the same style as is used on the power boards.

### Battery ###
The battery will be a [Sanyo CR2032](http://www.digikey.com/product-detail/en/CR2032/SY189-ND/1202936). It will be held using a [TE Connectivity 120591-1](http://www.digikey.com/product-detail/en/120591-1/A99328-ND/289426).

### Speaker ###
The speaker output located on the computer's system bus will be connected to a piezo buzzer on the [backplane](http://code.google.com/p/seabee3-ros-pkg/wiki/PowerBoardV2). This will be useful in the event that the computer fails POST.

Diameter: 0.54"

Height: 0.29"

Pin spacing: 0.3"

Pin diameter: 0.03"

We are using the [AI-1433-TWT-R](http://www.digikey.com/product-detail/en/AI-1433-TWT-R/668-1341-ND/1745432) from PUI Audio. The (-) terminal must be connected to ground and the (+) terminal must be connected to the Speaker signal. The Speaker signal is 5V active high.

![http://media.digikey.com/Photos/PUI%20Audio/MFG_AI-1433-TWT-R.jpg](http://media.digikey.com/Photos/PUI%20Audio/MFG_AI-1433-TWT-R.jpg)