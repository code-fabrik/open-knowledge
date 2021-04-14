# Semtech SX1276

The SX1276 is a LoRa transceiver.

## Hardware components

* Radio reset: one GPIO from the MCU is used to reset the radio. This is done
once, when the hardware is initialized.
* SPI: communication between the MCU and the SX1276 is done using SPI at 1Mb/s.
* Interrupts: 4 interrupts can notify the MCU of the completion or the timeout
of a task.
