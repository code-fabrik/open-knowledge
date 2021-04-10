# SPI

SPI is a protocol which allows one master chip to communicate with one or more
slaves. It is commonly used in sensors and SD cards and requires 3 or 4 lines.

SPI uses a data and a clock line to synchronize senders and recivers. The clock
signal is controlled by the master device. Whie the master is sending, data is
sent on the MOSI line (master-out/slave-in), or COPI
(controller-out/peripherial-in). If the master requires a response, it keeps
the clock running for some cycles to allow the slave to answer on the MISO/CIPO
line.

The last data line is the CS (chip select) line. It wakes up the slave or
optionally selectes which of multiple slaves is addressed. The CS line is
active low (held high during idling). Before transmission, the line is pulled
low to activate the device.

Multiple devices can be accessed by having multiple CS lines on the master side
and connecting them to the respective slave.

## Advantages

* Faster than asynchronous serial (about 10MHz)
* Simple hardware
* Multiple peripherials

## Disadvantages

* Many lines
* Fixed amount of data (since master keeps clock running for predefined amount
of cycles)
* Multiple peripherials require multiple CS lines
