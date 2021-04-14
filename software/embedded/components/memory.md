# EEPROM and FRAM

## EEPROM

EEPROM is the most commonly used non volatile memory in embedded systems. It
has a small footprint, is fast enough and can be controlled over I2C or SPI.
Many micro controllers already include a small amount of EEPROM. It has some
disadvantages, such as a limit of ~1M erase/write cycles, temperature
sensibility and a complicated write operation.

## FRAM

FRAM is about 10 times faster than EEPROM, has a limit of about 1T erase and
write cycles and is slightly less power hungry than EEPROM. For those reasons,
FRAM is also more expensive than EEPROM.

## Flash, eMMC, SD cards

External flash memory can be used to expand the internal flash to increase the
memory available for application code, usually through an SPI interface. Flash
memory can be memory mapped to include external flash, so no special code for
accessing the memory is needed, and it transparently extends the internal
memory.
