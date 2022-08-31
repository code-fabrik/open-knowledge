# Programmer and debugger ports

## Debugging

Adding a debugger port allows programmers to set breakpoints, step through the
running code and flash new bootloader and firmware binaries onto the device.

There are two debug protocols: JTAG and SWD. JTAG uses 20 pins, and is able to
power the MCU directly from the debugger. Additionally, it allows access to
more signals provided by the MCU. SWD uses 4 to 6 pins and only supports the
slightly more limited SWD protocol.

For simplicity, only the SWD interface is explained here.

### SWD interface

ARM processors usually use the SWD (Serial Wire Debug) interface. It consists
of the following pins:

| Pin | Type | Description |
|---|---|---|
| VREF | Output | Target voltage |
| SWDIO | Bidirectional | Data pin |
| SWCLK | Output | Clock signal |
| GND | - | Ground level |
| SWO | Output | Optional: trace output |


## Debug probes

Many debug probes are available. The following information is for the Black
Magic Probe.

The connector pins are laid out as follows (the names in brackets are the
configuration of the nrf9160 DK). Only VTREF, SWDIO, SWCLK and GND are
required. The signals TMS/TCK/TDO/TDI are from the JTAG standard and are not
used for most ARM MCUs.

| Notch | Column 1 | Column 2 |
|---|---|---|
| | 1 VTREF | 2 SWDIO/TMS |
| | 3 GND | 4 SWCLK/TCK |
| [ | 5 GND | 6 SWO/TDO |
| | 7 NC | 8 TDI/(NC) |
| | 9 NC/(GND) | 10 nRESET |

## Debug connectors

The debugger can be connected to the target in multiple ways:

* Placing a header with pins on the board: easy to solder, uses much space.
* Exposing the copper of the SWD traces on the board, along with alignment and
latch holes, to be used with a needle adapter: no soldering, easy to attach the
adapter.
* Exposing the copper of the SWD traces with alignment holes for a needle
adapter _without_ leg latches: no soldering, adapter must be pushed down on the
board manually.

The options are explained below.

### Header

Use a 2x5 pin header with 1.27mm connector spacing on the board. You can
optionally use a one-way shroud to ensure the connector is plugged in the right
way.

### Needle adapter with latches

The nrf9160 DK uses exposed pads compatible with the "TC2050-IDC" connector.

![10 pin needle adapter](images/10-pin-needle-adapter.jpg)

![10 pin needle adapter footprint](images/10-pin-needle-adapter-footprint.webp)

### Needle adapter without latches

The option without latches does not require the latch holes of the above
drawing. This makes the footprint a lot smaller, but might not be equally
convenient.

This option is compatible with the "TC2030-IDC-NL" connector.
