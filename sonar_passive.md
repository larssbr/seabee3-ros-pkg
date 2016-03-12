**Contents:**


# Introduction #
The sonar (passive) project is a primary task of focus this year, utilizing new methods for filtering, ping detection, and angle-of-arrival calculation. In the past, our team has been unsuccessful in completing the sonar task, which has proved essential for placing well in the Robosub Competition. Other than enabling SeaBee to locate and accomplish the pinger/octagon/grabber tasks, the sonar project can also be used for localization.
# Objective Information #
## 2012 Competition ##
TBA…
## 2011 Competition ##
**Vase and Sweeties House (PVC recovery and octagon)** – This task consists of an acoustic pinger located off the floor of the pool. Placed directly above the pinger is the box of candy for the vehicle to retrieve. Floating above the pinger on the surface will be an octagon representing your sweeties house. In order to obtain full points for the zone, the vehicle must surface fully inside the octagon.
There will be two different delivery points, a team will get points for surfacing within either area. However, only one pinger will be on during a run, and a vehicle surfacing within the area with the active pinger will receive more points. The team captain can choose to switch the active pinger, after the vehicle as recovered the Vase, but before the vehicle has surfaced. The vehicle can then transport the Vase to the second octagon, surface, and drop the Vase.
ORE pingers with a range of 22-40kHz.
### Scoring ###
| **Task** | **Max Points** |
|:---------|:---------------|
| Surface within an Octagon | 500            |
| Surface within the correct Octagon  | 2000           |
| Surface with the Vase | 1200           |
| Transport Vase to second Octagon | 800            |
### Diagrams ###

---

![http://i.imgur.com/1RXAE.jpg](http://i.imgur.com/1RXAE.jpg)

---

![http://i.imgur.com/Mud4t.jpg](http://i.imgur.com/Mud4t.jpg)

---


# Overview #
**Signal Path:**
Pinger  >>  water  >>  hydrophones  >>  charge amplifier >>  BP filter  >>  I/O board (aliasing filter, gain & ADCs) >>  DSP unit  >>  ROS Sonar Node

# Pinger #
The pinger outputs a 22, 23, 24, 25, 26, 27, 28, 29 or 30 kHz ping at 0.5 Hz (every 2 seconds) for 1.3ms with a sound level of 187 dB. The competition pinger is separated by 0.9 seconds from the practice pool pinger. We ~~are currently borrowing~~ stole an ORE Offshore pinger for testing purposes.


# Hydrophones #
See also [Hydrophones](Hydrophones.md).

We use an array of 4 [RESON TC4013 Hydrophones](http://www.reson.com/wp-content/uploads/2010/12/TC4013.pdf). The hydrophones will be arranged parallel to each other in a closely-spaced equilateral tetrahedron. The distance between the tips of two given hydrophones will be slightly less than half of the smallest wavelength we might see from the pinger.
## Testing ##
  * Need to verify the output frequency from the pinger. There was some confusion in the past because the pinger was believed to be set to 33khz, but FFT's recordings taken underwater showed a peak at 24khz. One method would be to open up the pinger and connect an oscilloscope in parallel with the speaker element.
  * Since the hydrophones generate a charge proportional to input amplitude, we need a circuit that will act as a dummy hydrophone when we feed an oscilloscope. This will just be a differentiator circuit with components chosen such that the impedance is close to that of the hydrophones.
## Charge Amplification ##
Charge amplification takes an input pulse from the hydrophones and outputs a voltage proportional to the total charge contained in the input pulse.

![http://i.imgur.com/fp9H3.png](http://i.imgur.com/fp9H3.png)

### More Info ###
[TI Charge Amp Info](http://www.ti.com/lit/an/sloa033a/sloa033a.pdf)

[Charge Amplifiers for Accelerometers](http://www.mkesc.co.uk/Chargeamps.pdf)

[Three Charge Amp Circuits](http://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&ved=0CDoQFjAB&url=http%3A%2F%2Fwww.fusor.net%2Fboard%2Fgetfile.php%3Fbn%3Dfusor_files%26att_id%3D198&ei=0SGbUN-cL6-MigKlwIHoCg&usg=AFQjCNFVHNDE4OVgXcNph5MkjjfHXzb0Lg&sig2=ss4MQ4zU1LdgHQYHZbRD4A)

# DSP Hardware #
Signal from all 4 hydrophones will be sampled and processed in real-time by a Danville Signal dspstak i/o board and dspblok processor.
## DSPstak ##
[The dspstak 192k48](http://danvillesignal.com/dspstak-productmenu/dspstak-i/o-modules/dspstak-c192k48) will be used for minor amplification (post charge amp) and sampling of the continuous-time hydrophone output. The 192k48 actually supports 8 output channels which we will not use.

The c192k48 has 10dB stepped programmable gain amplifiers (PGAs) for inputs with a range of 0 to +30dB. It accepts a 2V full scale input. After amplification, the signal is passed into an AD1938 4-channel, 16-bit, 192kHz  Σ-Δ ADC. The use of Σ-Δ architecture means actual accuracy is slightly higher than 16 bits. Reducing quantization error is of the utmost importance toward minimizing overall error.

## DSPblok ##
Upon conversion, the sampled data will pass into the [dspstak 21469](http://danvillesignal.com/dspstak-productmenu/dspstak-dsp-engines/dspstak-21469), which is built around an ADSP-21469 SHARC DSP. The module includes 1GB of RAM and an In-Circuit Emulator (ICE) for debugging purposes.

The DSP will be used to apply digital filters and, if necessary, more complex de-noising algorithms to the sampled signal. After the ping signal is as clean as possible, all 4 channels will be FFT'd. The FFT will provide the phase relationship between each channel, and from this we will find the azimuth and elevation of the incoming wave.

### Preliminary Thoughts ###
  * Signal path should be configurable block-wise via computer. Should able to do things like take filters in and out of path or say, select center frequency for a bandpass filter.
  * Hydrophone pairs used should be selectable. Pairs obviously need to be chosen such that they are linearly independent.
  * Specific processing operations on the DSP need to be simple. All the processing for a given ping signal needs to be finished before the next ping comes in if processing is to be done in real time. Real-time processing is not a necessity, however -- it may be easier to implement a system in which data is sampled as-needed instead of continuously. This requires further exploration.

# Sonar DAQ Initiative (Deprecated) #
The sonar DAQ project was an attempt before the 2012 competition to create a basic analog frontend to acquire usable data from the hydrophones. It featured an [instrumentation amplifier](http://en.wikipedia.org/wiki/Instrumentation_amplifier) circuit, 3 ADS7835 ADCs (12-bit, 500ksps, +/-2.5V input), and the Cheetah SPI host adapter. The gain to each hydrophone channel was adjustable with on-board trimmers. The resistors were configured as follows:
  * [R1](https://code.google.com/p/seabee3-ros-pkg/source/detail?r=1) = 1k
  * [R2](https://code.google.com/p/seabee3-ros-pkg/source/detail?r=2) = 1k
  * [R3](https://code.google.com/p/seabee3-ros-pkg/source/detail?r=3) = 10k
Thus, by adjusting the resistance on the R\_gain trimmers to 1.3k, we achieve a ~25X gain. Further testing needs to be done to determine the required gain for a ping signal picked up by the hydrophones at different distances from the pinger in the competition pool.

The PCB design can be found in the "beosub" repository under /trunk/Electrical/Altium/Projects/Sonar\_DAQ. It is a circular board with 3 amplifier/ADC channels designed to stack onto the Cheetah board. The amplifier circuit requires a bipolar voltage supply, so +/-12V and GND will need to be supplied from the new power board. The ADCs are powered by 5V from the Cheetah.

The "sonar\_driver" code can be found in the seabee3-ros-pkg repository. This ROS node was written to record data continuously from the hydrophone channels during a run in the competition pool. It takes successive samples from the 3 ADCs and dumps the data from the batch into comma-delimited text files. This process repeats until a SIGINT (ctrl-c) occurs. The text files can then be imported into Matlab for plotting or algorithm development. This code is inherently non-real-time, with significant delays between each batch to write the data out. It will need to be revised. The Cheetah bitrate to ADC sampling rate relationship is difficult to determine... with this code, a 40MHz bitrate corresponded to ~400kHz sampling rate.

Future design considerations:
  * use high-pass filter to reduce unwanted noise (60Hz AC hum)
  * need to differentiate between pings at multiple frequencies (e.g. 23kHz and 27kHz)
  * hydrophone reconfiguration, spacing, and mounts
  * SMA crimp connectors instead of BNC (purchased from China at http://www.rfsupplier.com/)