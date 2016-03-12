**Contents:**



# Hieu's Summer 2012 Killswitch #

### Details ###
The latest version of the kill switch features an [Arduino Nano](http://arduino.cc/en/Main/ArduinoBoardNano/), a reed switch, and 6 red/white [CREE XPE LEDs](http://www.cree.com/led-components-and-modules/products/xlamp/discrete-directional/xlamp-xpe) to control and display Seabee's motorkill status in a compact form factor.
  * Red LEDs glowing = KILL
  * White LEDs glowing = !KILL


### PCB ###
The Altium schematic and layout can be found in the "beosub" SVN repository at /trunk/Electrical/Altium/Projects/Kill Switch

Note: This design was based off the newer Arduino Nano, which has a different pinout than the one currently in use. Thus, a couple wires were soldered onto the back of the kill switch PCB as a temporary workaround.


### Arduino Sketch ###
The reed switch has three wires (red, blue, white) that plug into the kill switch PCB. This code assumes that the red wire is connected to the "-" on the 3-pin female header. The other 3-pin header is used to power the Arduino and to deliver the KILL signal to the power board.

When a magnet is detected, the output of the reed switch (KILL signal) goes low. The Arduino polls on this signal and controls the LEDs accordingly.

```
const int REED_SW = A0;
const int RED_LED1 = 3;
const int RED_LED2 = A4;
const int RED_LED3 = A2;
const int WHT_LED1 = A5;
const int WHT_LED2 = A3;
const int WHT_LED3 = A1;
//const int RED_BRIGHTNESS = 255;
//const int WHT_BRIGHTNESS = 255;

void setup() {                
  pinMode(REED_SW, INPUT); 
  pinMode(RED_LED1, OUTPUT);
  pinMode(RED_LED2, OUTPUT);
  pinMode(RED_LED3, OUTPUT); 
  pinMode(WHT_LED1, OUTPUT);  
  pinMode(WHT_LED2, OUTPUT);  
  pinMode(WHT_LED3, OUTPUT);
}

void loop() {
  int state = digitalRead(REED_SW);  //magnet in range, state=LOW
  digitalWrite(RED_LED1, state);
  digitalWrite(RED_LED2, state);
  digitalWrite(RED_LED3, state);
  digitalWrite(WHT_LED1, !state);
  digitalWrite(WHT_LED2, !state);
  digitalWrite(WHT_LED3, !state);
/*  
  analogWrite(RED_LED1, state * RED_BRIGHTNESS);    //glow RED when no magnet
  analogWrite(RED_LED2, state * RED_BRIGHTNESS);
  analogWrite(RED_LED3, state * RED_BRIGHTNESS);
  analogWrite(WHT_LED1, !state * WHT_BRIGHTNESS);   //glow WHITE when magnet
  analogWrite(WHT_LED2, !state * WHT_BRIGHTNESS);
  analogWrite(WHT_LED3, !state * WHT_BRIGHTNESS);
*/
}
```