# Low Power Modes

## Low-Power Run and Low-Power Sleep

Used for applications where peripherials can not be turned off, or where the
CPU must be kept running. The system clock is limited to 2MHz, getting the
power consumption to ~14uA.

## Stop Mode

Stop mode retains SRAM and Peripherials, but stops the high speed oscillators
(namely HSE, MSI, HSI) and only keeps LSE and LSI running. Peripherials are
able to wake the device. Power consumption of ~0.8uA.

## Standby Mode

SRAM is not retained in Standby Mode, but a small amount of SRAM2 is kept. The
GPIO pins can be configured before Standby Mode and will keep their
configuration. Wakup is done using one of 5 wakeup pins, the reset pin or an
external watchdog. RTC is powered by LSE or LSI and can wake the CPU. Uses
about 0.6uA.

## Shutdown Mode

Lowest power mode, uses about 8nA by switching off the voltage regulators and
disabling power monitoring. Wakeup using the wakeup pins or reset, RTC is
powered by LSE and can wake the device. Not available for all MCUs.
