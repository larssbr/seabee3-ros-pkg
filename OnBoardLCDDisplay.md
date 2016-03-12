# Introduction #

The goal is to incorporate a reasonably sized LCD Display into the kill switch circuitry. The function of the LCD would be to display status updates like pressure readings, kill switch status, objective status, as well as function as a convenient resource for debugging software loaded on the sub.

## Things to display ##
  * Internal pressure
  * External pressure
  * Temperature
  * Battery state-of-charge and voltage (maybe show curve)
  * Scroll running ROS nodes.
  * Flash alert if a ROS node crashes

# Selection #

Serious Integrated SIM205 (http://www.seriousintegrated.com/product-services/sim205/)

![http://www.seriousintegrated.com/content/SIM205_Splash.jpg](http://www.seriousintegrated.com/content/SIM205_Splash.jpg)

Screen Size: 4.3" diagonal
Module Size: 94mm x 116mm (5.87" diagonal) -- still waiting on depth from manufacturer

**PROS**
Good size, color, high resolution, USB interface, GPIO pins for kill switch reading along with other future sensors etc.
Also has a ton of features that can be taken advantage of for future projects.

**CONS**
Might be difficult to program; but, I've (Max) been in contact with the manufacturer who might include us in their GUI-creating software beta program.


# Underwater Visibility Considerations #
## Color ##

![http://www.educatedangler.com/images/stories/magazine/diagram3_220.jpg](http://www.educatedangler.com/images/stories/magazine/diagram3_220.jpg)
![http://www.educatedangler.com/images/stories/color_graph.jpg](http://www.educatedangler.com/images/stories/color_graph.jpg)

Given perfect conditions, red and oranges are the first colors to disappear, to be absorbed by the water, followed later by yellows, greens, purples, and blues in that order.  Take into account that this is a general rule of thumb because light absorption can be affected by what is suspended in the water.Things like plankton or sediment can reflect or absorb colors before they would normally be absorbed in clear water

The angle of the light plays a big role in light penetration.  As the sun comes up and sets during the daylight cycle the light from the sun will be hitting the surface of the water at different angles.  The best light penetration occurs during the most direct sunlight period, high noon, when the sun is closest to a 90% angle to the water surface.  At angles of 40% or less to the water surface light penetration falls off dramatically, these periods coincide with sunrise and sunset.



### Refraction ###
In refraction, the light rays are bent as they pass from one medium to another of different density. In diving, the refraction occurs at the interface between the air in the diver's mask and the water. The refracted image of an underwater object is magnified, appears larger than the real image, and seems to be positioned at a point three-fourths of the actual distance between the object and the diver's faceplate.

This displacement of the optical image might be expected to cause objects to appear closer to the diver than they actually are and, under some conditions, objects do indeed appear to be located at a point three- fourths of their actual distance from the diver. This distortion interferes with hand-eye coordination and accounts for the difficulty often experienced by novice divers attempting to grasp objects under water. At greater distances, however, this phenomenon may reverse itself, with distant objects appearing farther away than they actually are. The clarity of the water has a profound influence on judgments of depth: the more turbid the water, the shorter the distance at which the reversal from underestimation to overestimation occurs. For example, in highly turbid water, the distance of objects at 3 or 4 feet (0.9 or 1.2 m) may be overestimated; in moderately turbid water, the change might occur at 20 to 25 feet (6.1 to 7.6 m); and in very clear water, objects as far away as 50 to 75 feet (15.2 to 22.9 m) might be underestimated.

### Scatter ###
Scatter occurs when individual photons of light are deflected or diverted when they encounter suspended particles in the water. Although scattering also occurs in air, it is of much greater concern under water because light is diffused and scattered by the water molecules themselves, by all kinds of particulate matter held in suspension in the water, and by transparent biological organisms. Normally, scatter interferes with vision and underwater photography because it reduces the contrast between the object and its background. This loss of contrast is the major reason why vision is so much more restricted in water than in air (Duntley 1963, Jerlov 1976); it also accounts for the fact that even large objects can be invisible at short viewing distances. In addition, acuity or perception of small details is generally much poorer in water than in air, despite the fact that the optical image of an object under water is magnified by refraction (Baddeley 1968). The deterioration increases greatly with the distance the light travels through the water.

### Absorption ###
Light is absorbed as it passes through the water, and much of it is lost in the process. In addition, the spectral components of light, the wavelengths that give rise to our perception of color, are differentially absorbed. Transmission of light through air does not appreciably change its spectral composition, but transmitting light through water, even through the clearest water, does, and this can change the resulting color appearance beyond recognition. In clearest water, long wavelength or red light is lost first, being absorbed at relatively shallow depths. Orange is filtered out next, followed by yellow, green, and then blue. Other waters, particularly coastal waters, contain silt, decomposing plant and animal material, and plankton and a variety of possible pollutants, which add their specific absorptions to that of the water.
### Attenuation & Transmission ###
Light attenuation in water obeys the Beer Lambert Law, which suggests that Intensity (I) is equal to I\_0 (initial intensity)times e^-kz where k ranges from roughly .1 to 1.5 depending on the conditions of the water.