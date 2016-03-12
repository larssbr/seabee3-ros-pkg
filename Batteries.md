# Old Batteries #

The SeaBee AUV uses two 6-cell lithium-polymer batteries, which are enclosed inside the hull during runtime. These batteries supply power directly to the power board, allow SeaBee3 to operate untethered for hours (theoretically).


### Charging ###
New Charging Instructions (Updated 12/4/2012):
> We use the Thunder Power RC Charger that has a wall adapter (AC/DC charger, it's the biggest one). Right now it seems we are sharing it with Aerial, so it's location will be set when we organize, but it is in the software lounge. Attach the Batt +/Batt - on the right side of the charger to the Battery leads. The balancing board should also be attached to the two balancing connectors on the battery. The battery connects to the two bottom left connectors on the board labeled 2-3s and 6s. Once all of this is connected, plug the charger into the wall. On the menu select Lithium Polymer batteries, 6s (for 6 cells) and 2.5A (VERY IMPORTANT). The batteries technically should charge at 4.0A but the charger will give you an error as it steps up the current once it gets to 2.5A if you set it this way. The batteries should not be charged about 25.2V, but the charger should automatically stop. Because we have to charge at a much lower current, it will take the batteries a long time to charge. Allow several hours per battery. Batteries 1-3 can be charged, battery 4 is damaged.

Previous Charging Instructions:
> In one of the charger boxes (hopefully in the top left of the USCR shelves). There should be a charger and a connector with a bunch of wires hanging out of it. The wires are  the individual cell breakouts, Bat +, and Bat -. The breakouts are attached to the little connector and plug into the only available spot on the charger. Bat + and Bat - are red and black accordingly and are color coded on the charger so just plug them in. Then you just plug the charger into the wall. It should peep and and be happy. Ignore the big clips of red and black, they are used with an AC-DC converter pre-stage.

> The menu should already be set to a 6 cell lipoly charger of 6,000mAh. If not, figure out how to go through the menu and make it so, it's not too hard and there are directions. Don't worry that we have 10,000mAh cells, it's compatible, just takes longer. Then just hold enter and it should start charging and tell you that the cell balancer is connected, charge rate and overall voltage. Do not let it get much above 24V (3.7x6 = 22.2 nominal voltage), though it should shut off automatically when finished, but I've never let it run for more than a few hours. After being fully charged it is normal for the batteries to loose just under a volt of charge per day if they are unused.


# Planned Battery Upgrade #
The [power requirements](http://code.google.com/p/seabee3-ros-pkg/wiki/PowerRequirements) imposed by the the [ADL computer](http://code.google.com/p/seabee3-ros-pkg/wiki/Computing) and thrusters etc. mean that we need to step up the battery size if we want Seabee to be able to last in the pool. As such, we are looking into upgrading from dual 22.2V 5Ah Li-Polys to dual 25.9V 10Ah Li-Poly batteries:

http://www.batteryspace.com/highpowerpolymerli-ionbattery259v10ah259wh40aratewithpcmandfuelguageafireretardantbag.aspx

  * Dimensions are about 3.3" x 3.4" x 6.3".

  * Weight is 4 lb.

  * High discharge rate. A single one can support 40A max, meaning that the only limiting factor would be cabling

  * They have charge balancing built in. That means we don't need to do any of our own balancing stuff, but that we can be sure that they will charge and discharge evenly. We just need one of their chargers: http://www.batteryspace.com/smartcharger28afor259vli-ionpolymerrechargeablebatterypackstandardfemaletamiyaplug.aspx