# LSM6DSM

## Requirements

* [I2C](../../protocols/i2c.md)

The LSM6DSM can operate in four modes. Only mode 1 (host <-> device) and
communication over I2C will be described here.

## Pins

* SDO: Sets the LSB of the device address
* CS: Sets communication mode (0=SPI, 1=I2C). Connect to VCC
* SCL: Serial clock, used for I2C. Connected to the &mu;C SCL
* SDA: Serial data, used for I2C. Connected to the &mu;C SCL

## Registers

See Chapter 9 of the [datasheet](LSM6DSM.pdf) for the register mapping.

## Common actions

### Who am i

The device can be asked for its Who-Am-I value to make sure that I2C is
working. The WAI register address is 0x0F and contains the value `0b01101010`
or `0x6A`.

To read the register, the master node must do the following:

* Send a `SAD+R` frame
* Send a `DATA` frame containing `0x0F` or `0b00001111`
* Receive one `DATA` frame containing `0x6A`
