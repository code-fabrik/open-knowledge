# LIS3DH

## Operation modes

The LIS3DH can be put into three operation modes; low-power, normal and
high-resolution mode. This controls how many bits of data are measured by the
IMU.

| Mode | CTRL_REG1[3] | CTRL_REG4[3] |
|---|---|---|
|Low-Power|1|0|
| Normal | 0 | 0 |
|High-Res| 0 | 1 |

Additionally, CTRL_REG1 can be used to power down the sensor and to enable or
disable the axes individually.

Excerpt of the configurations:

| Mode | ODR3 | ODR2 | ODR1 | ODR 0 | LPen | Zen | Yen | Xen |
|---|---|---|---|---|---|---|---|---|
| Power down | 0 | 0 | 0 | 0 | nc | 0 | 0 | 0 | 0 |
| High-res 1Hz