# Thermal Analysis #

Current plan is to stick with liquid cooling, with an integrated radiator attached to the endcap.

TDP = 45 W

<a href='http://imgur.com/5acgFi8'><img src='http://i.imgur.com/5acgFi8.jpg' alt='' title='Hosted by imgur.com' /></a>
**Figure 1** _CFD analysis on copper mini-radiator (2-in diameter, .15" ID-tube), no initial airflow, gravity in X-dir, water coming in at 340 K (yesss this is probably too hot for the pump.. so the heat fluxes here are maximums for the ambient conditions, ambient air at 293 K, .0001 m^3/s flow rate, probably want coolant to be no more than 5-10 C hotter than ambient, only dissipates 1.7 watts_

From data that generated figure 1, the outer surface of the coil's average heat flux to air is 481 W/m^2.

Which gives a convective heat transfer coefficient, h = 10.23 W/(m^2\*K).


Fitting in nicely between the accepted values of 5-25 W/(m^2\*K) for air free-convection.

## Hand-calculation key numbers.. ##
Sorryy this really should've been done a long time ago.

  * **Heat Capacity of air enclosed in proposed 8.5" x 12" hull**:  13 J/K _(i.e. to change temp by 10 degrees C @ 15 watts dissipation would only take 9 sec)_

  * **5-watt radiator** (in stagnant air, using h from above w/ allowable 10 degree temp rise) would require 3.3 meters of 0.375" tubing.  (e.g. the mini compact radiator above that fits on the hull can give a surf area around .003 m^3 which makes itself a 0.3 W-radiator.)

  * **0.5 L of coolant** would take 35 min to heat up by 10 degrees @ 10 W dissipation.  Or combined w/ 5-watt radiator, 1 hour and 10 minutes.  Or @ 45 W w/ no radiator, 7.8 min.

  * Makes more sense to maximize amount of coolant rather than radiator size due to our lack of fans/convection in air.

  * **What if we add ice to radiator?**  Then we can get a 30 degree delT.. which would turn a 5-watt radiator to a 30-watt radiator.. or the .3 W radiator (above) into the 1.7-watt radiator (as depicted on the figure).  _this is a worst case approx, as it assumes the ice only cools the air which then cools the radiator. if perfectly pressed up against radiator.. would be only a function of the radiator's conduction so this would actually be a whole lot better_  Or, as most teams use a passive solution, the temp rise can be much greater.. and you can do the math.

  * **Conclusion**:  There's a reason teams use ice + passive cooling.  Its the most compact solution to test in-air.  Or we can grab a fan to increase the h from 10 to 200+.  (Now that i've crunched some of the numbers, i've realized our current solution is no where near "over-kill" for air operation.. the current liquid cooling system only works to increase testing time)

## CFD-Determined h's ##
#### 6061 Cylinder with gravity not along axis.  In Air. 10 deg diff ####
  * 5mph, perpendicular to grav, (not along axis), **h = 28.437**
  * 0 mph, **h=5.696**
#### 6061 Cylinder with gravity not along axis.  In Water. 10 deg diff ####
  * 0 mph, **h=1657.6**
  * 5 mph, **h=6498.541**
#### Copper Plate w/ gravity along thickness.  In water. 10 deg diff ####
  * 0 mph, **h=587**

_all h's above have units of W/(m^2\*K)._

_As a sanity check, all the #s above match with some established ranges given [here](http://www.polydynamics.com/heat_transfer_revised.pdf)
## Basic Heat Transfer Equations ##_

  * q\_dot=h\*A\*delT  _(Convective heat transfer, h is empirical convection constant primarily affected by state of fluid, A is surf area, delT is temperature difference, qdot is heat flow)_

  * q\_dot=k\*A\*delT/thick _(Conduction heat transfer.. only difference is k is per unit length, not area)_

  * Q=C\*delT _(Heat capacity equation)_

  * All of these can be rearranged to thermal resistances (where the analog of current is heat flow, voltage is temp.. i.e. conductive resistance = (k x Thick x A)^-1


---

# older stuff from last night #
## CFD takes too long.. Hand-Calculation Easier ##
Okay.. so.. back-of-the-envelope calc time.

Normally, coolant should probably not be 50 degrees C hotter than ambient.  Maybe only 5-10 degrees.

**Convective Heat Transfer 101**
  * dot=h\*A\*delT
Qdot is heat flow, h is an empirical constant, A is the surface area, delT is temperature difference between fluid and solid.

Using the h found via Flow Simulation, and say.. a delT of 10 C, and our TDP as Qdot (45 W)..

Required surface area = 0.44 m^2  (yes, this is a lot)  And yes, this is more than the original passive cooling requirement.  (Its really the same, but the temperatures aren't allowed to be so hot, so the area has to be larger...)

So...

  * Option 1:  Somehow manage to get that amt of surface area
  * Option 2:  Set a time-limit for testing in air.  This should be a while, given water's large heat capacity.

_Note:  This explains why Seabee 3's cooling tubes actually do get pretty warm when running in-air.  Our current radiators really only do their job well w/ a fan, given that most of their surface area is hidden within the radiator.. so the trapped air heats up pretty fast.  Not to mention the drastically higher heat transfer coefficients just due to the increased flow velocity._

**Thus, rather than design for maximum heat flow in air, we may have to design w/ heat capacity and operation time in-mind.  Physically, it isn't practical to try dissipating 45 W of heat passively in air.  So, the only real advantage our method of liquid cooling (w/out fans) has over a totally passive heat-conduction method is its larger heat capacity which will increase the testing time by alot**

## To-Do List ##
  * How much time do we have to test enclosed in-air?  (this is an easy hand-calc if we approx that no heat gets dissipated by the radiator and all heat from computer goes to water (i.e. assume a really low thermal resistance for the water block).  And maybe.. temp rise of 10 degrees?  I'd think this is primarily limited by the pump specs.. and the water block's thermal resistance curve... i'll do it at some point tomorrow.
  * Pick a water block.  I'm thinking from here:  http://www.customthermoelectric.com/Water_blocks.html
  * Getting a reservoir would really max our test-time and make replenishing the coolant alot easier.
  * Pick pump.