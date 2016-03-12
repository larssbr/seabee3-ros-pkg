# Introduction #

The following explains what a reed switch is and discusses some relevant information about reed switches. Scroll further down for explanations about magnetism. At the bottom we'll discuss the final mechanism to implement the reed switch as our kill switch.

Here's the link to the reed switch we bought:
http://www.digikey.com/scripts/DkSearch/dksus.dll?WT.z_header=search_go&lang=en&keywords=HE503&x=0&y=0&cur=USD

Test results will appear later.


# Criteria: #
  * normally OPEN(NO)
  * stand pressure 40ft underwater
  * magnetically powerful enough to go through 1/4in aluminum
  * magnets canNOT affect the rest of the electronics

## Definition: ##

The reed switch contains a pair (or more) of magnetizable, flexible, metal reeds whose end portions are separated by a small gap when the switch is open. The reeds are sealed airtight in opposite ends of a tubular glass envelope.

A magnetic field (from an electromagnet or a permanent magnet) will cause the reeds to come together, thus completing an electrical circuit. The stiffness of the reeds causes them to separate, and open the circuit, when the magnetic field ceases.

http://upload.wikimedia.org/wikipedia/en/e/ef/Reedswitch.PNG


# THIS IS THE DATA SHEET FOR THE REED SWITCH WE'RE USING #
http://www.hamlin.com/specsheets/MDCG-4.pdf


## Helpful Glossary ##
  * orm A: normally open contact (N. O.)
  * orm B: normally closed contact (N.C.)
  * orm C: change over contact (S.P.D.T.)
  * orm E: Bistable / Latching
  * T: Ampere Turns; Parameter that describes magnetic sensitivity.

## Explanations of Different Types of Reed Switches ##
http://educypedia.karadimov.info/library/reed_relays.pdf
  * retty much must be the typical regular NC dry reed switch
  * O mercury wetted (must be nearly upright always)

## Possible Types of Relevant Switches ##
### Mercury Wetted ###
Mercury-wetted relays are fast in operation and have relatively
good load carrying capacity and long life. The mercury films are
reestablished at each contact closure and contact erosion is
eliminated. The mercury films are stretchable, there is no contact
bounce and  because it is a mercury contact, the contact resistance is very low and idea for low level switching applications.

## Normally OPEN ##
It's the most common reed switch because it's the most reliable. This is the one we are using. It's also cheaper.

## Normally Closed ##
When the reed switch has a magnet already inside it to keep it closed, and when you bring another magnet close to it, it opens. It sounds sketch because it is sketch and no one has come up with a small and reliable NC reed switch because there's issues with the switch reserving charge. Let's just forget about this in the case that it may cause problems.


> ### Common Problem and Solution: ###
> The switch itself holds a charge after the magnet is removed.

Simple test with arduino, have an led set to turn on when a digital pin is low, feed power through the reed switch to that pin. Add a magnet the led turns off immediately, remove the magnet there is a 15 or 20 second delay before the led turns back on. Remove the reed switch and just touch the power wire to the pin wire together and led turns off and on immediately. I even tried just putting power to the leg of the switch on the same side as the arduino pin to make sure the switch wasn’t getting stuck closed and it still had the delay when the power was removed. You can add a pull down resistor on the pin side to correct this, but it’s annoying having to use up another component for it.

# Things to Check #
### Magnetic fields ###
Reed relays in general can be characterized as susceptible to the
influence of external magnetic fields. It is important to **keep reed
relays at a proper distance from each other** because of the
possibility of magnetic-interaction between them. Proper
magnetic shielding must be used to contain stray magnetic
fields. When installing reed relays into equipment, one should be
aware of the devices within that equipment which can produce
magnetic fields. The relays being installed into that equipment
should be positioned as far as away as possible from any stray
magnetic fields and should be shielded to prevent false
operations.

### Temperature ###
Differential expansion or contraction of reed switches and
material used in relay assemblies can lead to fracture of the
switches. Reed relays are capable of withstanding temperature
cycling or temperature shock over a **range of at least -50°C to -
100°C.** These limits should be applied to the application to
prevent switch failure.



# Magnetism #
http://www.meder.com/fileadmin/meder/pdf/en/Technical_Documents/Reedswitch_used_with_permanent_magnet.pdf

_**Some VOCAB**_

**Gauss**: unit

**Lodestone** (also called Magnetite) is a naturally-occurring "permanent" magnet mineral. By "permanent," it is meant that the material maintains a magnetic field with no external help. The characteristic of any magnetic material to do so is called retentivity.

**Ferromagnetic** materials are easily magnetized.
Ferromagnetic elements: http://en.wikipedia.org/wiki/Category:Ferromagnetic_materials

**Paramagnetic** materials are magnetized with more difficulty.

**Diamagnetic** materials actually tend to repel external magnetic fields by magnetizing in the opposite direction.

# HOW TO SHOP FOR MAGNETS #

N Grade of magnet = strength
**N grade** of the magnet is the maximum energy product of the material. Basically if the BHmax is 52MGs (Mega Gauss) then the grade will be N52. The BHmax is the max magnetic energy product.

Fact sheet has a good GRADE chart:
http://www.magnet4sale.com/faq/

Basically the SmCo magnets are stronger and smaller and less corrosive and not a whole lot more expensive. But they are harder to find. Both are "rare earth metals." Nd magnets need to be plated in something but the Ni-Cu-Ni plating (shiny silver) is the best out there. Doesn't really prevent rusting inside though. The corrosion mostly happens in like 175C temps so that shouldnt be a concern.

## Corrosion ##
THIS IS A PROBLEM IN SALT WATER PLACES.

To prevent corrosion: use magnets covered in nickel, gold, zinc, epoxy.
Especially for warm, wet places, it's important to have a plated magnet.
http://www.vacuumschmelze.com/index.php?id=82
HOWEVER, it is possible that the magnet corrodes inside the plating and the plating falls off causing major mechanical problems.


Or you could use a Nd-Fe-B magnet mixed with one of the following elements: Co,Ga, Nb, Mo and V. That's what the below company does.
http://www.vacuumschmelze.com/index.php?id=82


VACODYM 6xx / 8xx
![http://www.vacuumschmelze.com/uploads/pics/korossion_1_182_01.jpg](http://www.vacuumschmelze.com/uploads/pics/korossion_1_182_01.jpg)
conventional Nd-Fe-B
![http://www.vacuumschmelze.com/uploads/pics/korossion_2_182_01.jpg](http://www.vacuumschmelze.com/uploads/pics/korossion_2_182_01.jpg)

Under HAST conditions (Highly Accelarated Stress Test (HAST, 130 °C, 95 % moisture):
![http://www.vacuumschmelze.com/uploads/pics/Grafik_Auslagerungsdauer_en.jpg](http://www.vacuumschmelze.com/uploads/pics/Grafik_Auslagerungsdauer_en.jpg)


http://spontaneousmaterials.com/Papers/Corrosion.pdf

Explanation of Nd-Fe-B Corrosion:
http://spontaneousmaterials.com/Papers/Corrosion.pdf




http://robotics.ee.uwa.edu.au/theses/2004-AUV-Gonzalez.pdf page 117

cool magnet diagrams
http://www.meder.com/miniature-switch_ksk-1a04-us.html?&tx_jppageteaser_pi1[backId]=2886

![http://www.sparkfun.com/datasheets/Components/Buttons/RS-01C.jpg](http://www.sparkfun.com/datasheets/Components/Buttons/RS-01C.jpg)

history overview
http://www.meder.com/info-reed-switch4.html

Super underwater ones
http://stevenengineering.com/Tech_Support/PDFs/21GOPRODL.pdf

http://en.wikipedia.org/wiki/Reed_switch


  * Text in **bold** or _italic_
  * Headings, paragraphs, and lists
  * Automatic links to other wiki pages