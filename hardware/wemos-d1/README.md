# Wemos D1

The Wemos D1 is a development board containing the ESP-8266EX chip capable of
WiFi 802.11b/g/n. It is compatible with many Arduino sketches and can be used
for very small WiFi capable devices.

## Installation

To use the Arduino IDE with the D1, you first need to install the CH340 driver
since the D1 uses a slightly different USB serial console than the Arduinos.
Then, open the Board Manager and add URL mentioned in the following
documentation to download the config for the D1:
https://github.com/esp8266/Arduino

To be allowed to use the USB tty, run the following command and replace the end
with your own username:

```bash
sudo usermod -a -G dialout USERNAME
```
