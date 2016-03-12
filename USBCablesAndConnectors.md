# Introduction #

These are cables and connectors that could potentially be used on the new AUV. Most connections will be dealt with using the backplane system, but we still need to decide on cables to be used with devices that have specific USB connectors built in.


# Devices #

  * Point Grey Firefly x4 - Mini USB B
  * Xsens MTi - Serial adapter has a full-size USB A receptacle built in. We will most likely desolder and bypass this.
  * dspStak 21469 - ICE has mini B, base board has fulls-size B. I'm not sure which one of these we will be using on the sub yet.
  * SIM205 display - Mini B

# Cables #

http://www.l-com.com/product_images/detail/PWD_CAA-90RMB5-_.JPG

http://www.l-com.com/usb-right-angle-usb-cables-straight-a-male-to-right-angle-mini-b5-male

L-Com makes these molded right angle connectors, which could be useful in tight spaces, specifically camera pods. These could be good for any mini usb b devices though, so cameras, display, and sonar. The downside is that they don't have crimpable connectors or anything, so we would need to but normal cables and hack off the non-right-angle ends. I think we should commit to doing this, since the options for USB cables are very limited and we can't do much better than this for minimizing the space that they take up.

|Device | Cable |
|:------|:------|
| Sonar (ICE) | [Right Angle Mini B](http://www.l-com.com/usb-right-angle-usb-cables-straight-a-male-to-right-angle-mini-b5-male) |
| Sonar (COM) | [Right Angle B](http://www.l-com.com/usb-right-angle-usb-cable-straight-a-male-right-angle-b-male-03m) |
| Camera x4 | [Up Angle Mini B](http://www.l-com.com/usb-right-angle-usb-cables-straight-a-male-to-up-angle-mini-b5-male) |
| Display | [Right Angle ??](http://www.l-com.com/usb-right-angle-usb-cables-straight-a-male-to-right-angle-mini-b5-male) (Need to check this) |
(All of these connectors are right angle with respect to the cable. The angle I specify refers to the rotation of the plug)