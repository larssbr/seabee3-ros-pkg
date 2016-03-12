_This is all a summary of information taken from the article linked under "Further Reading"._

# Overview #

Models the axial flow velocity of the thruster using ambient flow velocity compared to the propeller shaft velocity, which can be in three separate states defined as critical advance ratio (CAR). In addition to this the angle of the incoming ambient flow is analyzed and the Critical Incoming Angle (CIA) is defined to describe the separate thrust force states.

# Math #

## Symbol Definitions ##

| V<sub>in</sub> | voltage controlled input (V) |
|:---------------|:-----------------------------|
| Ω              | propeller shaft velocity (rad/s) |
| T              | propeller thrust (N)         |
| Q              | propeller shaft torque (Nm)  |
| u<sub>p</sub>  | axial fluid velocity at propeller (m/s) |
| u<sub>a</sub>  | ambient axial fluid velocity (advance speed) (m/s) |
| u              | vehicle velocity (m/s)       |
| K<sub>T</sub>  | thrust coefficient (-)       |
| J<sub>0</sub>  | advance ratio (-)            |
| J| critical advance ratio (CAR) (-) |
| p              | density of water (kg/m<sup>3</sup>) |
| m              | effective mass of water (kg) |
| D              | propeller disk diameter (m)  |
| A<sub>p</sub>  | propeller disk area (m<sup>2</sup>) |
| t              | thrust deduction number (-)  |
| w              | wake fraction number (-)     |

## Equations ##

**_To view the derivation of these equations along with diagrams for clarity, view the linked document at the end of this page_**

### Thrust Model ###

This is the basic model that does not take into account any angular forces on the thrust force, but does take into account

_T = 2pA<sub>p</sub>(k<sub>1</sub>u + k<sub>2</sub>DΩ)(k<sub>1</sub>u + k<sub>2</sub>DΩ - u) = 2pA<sub>p</sub>(k'<sub>1</sub>u<sup>2</sup> + k'<sub>2</sub>uDΩ + k'<sub>3</sub>D<sup>2</sup>Ω<sup>2</sup>)_


### Incoming Angle Effect on Thrust Force ###

_T = K<sup>a</sup><sub>T</sub>pD<sup>4</sup>Ω|Ω|_

_K<sup>a</sup><sub>T</sub> = K<sup>0</sup><sub>T</sub> + f<sub>a</sub>(J<sub>0</sub>, θ)_

where _K<sup>0</sup><sub>T</sub> = K<sub>T</sub>(J<sub>0</sub> = 0)_ and

_f<sub>a</sub> = (K<sup>0</sup><sub>T</sub> - K<sup>+</sup><sub>T</sub>)[sin(θπ/θ<sup>*</sup><sub>1</sub>2) - 1], 0 ≤ θ ≤ θ<sup>*</sup><sub>1</sub>_

_f<sub>a</sub> = K<sub>a</sub>J<sub>0</sub>sin(θ - θ<sup>*</sup><sub>1</sub>π/π - θ<sup>*</sup><sub>1</sub>2), θ<sup>*</sup><sub>1</sub> < θ ≤ θ<sup>*</sup><sub>2</sub>_

_f<sub>a</sub> = [K<sub>a</sub>J<sub>0</sub>sin(θ - θ<sup>*</sup><sub>1</sub>π/π - θ<sup>*</sup><sub>1</sub>2) - (K<sup>-</sup><sub>T</sub> - K<sup>0</sup><sub>T</sub>)]cos(θ - θ<sup>*</sup><sub>2</sub>π/π - θ<sup>*</sup><sub>2</sub>2) + (K<sup>-</sup><sub>T</sub> - K<sup>0</sup><sub>T</sub>), θ<sup>*</sup><sub>2</sub> < θ ≤ π_

_θ<sup>*</sup><sub>1</sub>(u) = π/2 - a<sub>1</sub>u_

_θ<sup>*</sup><sub>2</sub>(Ω, u) = a<sub>2</sub>u(Ω - b<sub>2</sub>) + c<sub>2</sub> + θ<sup>*</sup><sub>1</sub>_

# Further Reading #

_Accurate and Practical Thruster Modeling for Underwater Vehicles_

http://www.sciencedirect.com/science/article/pii/S0029801805001836

https://dl.dropbox.com/u/9050547/Accurate%20and%20practical%20thruster%20modeling%20for%20underwater%20vehicles.pdf