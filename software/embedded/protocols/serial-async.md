# Serial asynchronous communication

## Requirements

* [SPI](spi.md)

For asynchronous communication, since there is no clock signal, the sender and
the receiver must agree on four parts of information before being able to
exchange data: the number of data bits, number of synchronization bits, number
of parity bits and baud rate. A frame consists of the following information:

```text
[Start][  Data  ][Parity][  Stop  ]
[1 bit][5-9 bits][1 bit ][1-2 bits]
```

The start bit is a falling edge, the stop bit a rising edge. The line is held
high if no transmission is ocurring. The parity bit is optional and not widely
used.

Protocols are usually named after the baud rate and an abbreviation of the
above characteristics. A protocol named `9600 8N1` would mean 9600 bps, 8 data
bits, no parity, 1 stop bit. The LSB is transferred first.

## UART

An UART is a piece of hardware which translates signals into serial packets and
controls the attached data lines.

Asynchronous communication only works between two devices, since there would be
massive bus contention otherwise.

## Disadvantages

* Complex circuits required
* Large overhead (at least 20%)
* Only between two devices
* Maximum speed about 230kHz
