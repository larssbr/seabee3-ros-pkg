# Overview #
jaus\_adapter subscribes to relevant ROS topics, runs through a state machine designed to interface with the JAUS-compliant workstation, and encodes/decodes data packets for that protocol.

The JAUS standard documents can be found under the "Downloads" tab. The documents that start with "AS" are the official standards. The Jr MiddleWare User's guide details how to use the library for message passing. The Interop-Challenge pdf explains what needs to be done for the competition.

# Dependencies #
Junior MiddleWare
  * A free, open library that complies with the JAUS standards.
  * Simplifies message passing using JAUS

# Limitations #
  * This implementation of a JAUS-compliant communication node for ROS is currently only compatible with i386 systems due to the use of a pre-compiled library 'libjunior.a' which is compiled for the i386 architecture. This will be changed soon.

# How JAUS Works #
## Message Structure ##
Each message is composed of a 4 byte unsigned header. This header dictates what the message is for, and all messages require a header which I call "msg\_id" and call out as a hex value.

## Handshaking ##
The initial handshake between a client and the JAUS Interface is started by calling:
```
JrConnect()
```

## Sending and Receiving Messages ##
Messages are sent by calling:
```
JrSend()
```

Messages are received by repeatedly calling:
```
JrReceive()
```

# Algorithm #
  1. Subscribe to relevant ROS topics
  1. Initiate state machine
  1. At each time-step:
    1. Read data from message buffer
    1. Process and act on most recent message
    1. Update state machine
    1. Create and send JAUS messages via Junior, if necessary

# Useful Links #
  1. JVT Tool (server for testing): http://www.usaric.org/JVT.html
  1. USARIC Forums: http://usaric.org/simplemachinesforum/index.php?board=2.0
  1. USARIC Main Site: http://www.usaric.org/