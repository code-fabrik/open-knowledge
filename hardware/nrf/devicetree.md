# Devicetree

A devicetree is a tree formatted definition of the devices and capabilities of
a processor or board.

```dts
/dts-v1/;

/ {
        a-node {
                subnode_nodelabel: a-sub-node {
                        foo = <3>;
                        label = "SUBNODE";
                };
        };
};
```

## Trees

Devicetrees can have nodes and subnodes, as well as labels. The above tree
contains the following hierarchy: `/a-node/a-sub-node`. The lowest node
is labelled as `subnode_nodelabel`. Labels can be referenced in other nodes.

Nodes can contain one or multiple properties, such as `foo` and `label` in the
above example. `foo` is a `cell` (32 bit uint) with value 3, `label` is a
string containing `SUBNODE`.

Most of the time, a devicetree describes the hardware of a processor. If a
processor contains for example an I2C bus that has three peripherials
connected, the following tree would describe it:

```dts
/dts-v1/;

/ {
        soc {
                i2c@40003000 {
                        compatible = "nordic,nrf-twim";
                        label = "I2C_0";
                        reg = <0x40003000 0x1000>;

                        apds9960@39 {
                                compatible = "avago,apds9960";
                                label = "APDS9960";
                                reg = <0x39>;
                        };
                        ti_hdc@43 {
                                compatible = "ti,hdc", "ti,hdc1010";
                                label = "HDC1010";
                                reg = <0x43>;
                        };
                        mma8652fc@1d {
                                compatible = "nxp,fxos8700", "nxp,mma8652fc";
                                label = "MMA8652FC";
                                reg = <0x1d>;
                        };
                };
        };
};
```

## Unit addresses

The above tree contains `unit addresses`, the part after the @ sign in the node
names. Unit addresses can describe different things depending of the type of
hardware they are describing:

| Hardware type | Unit address meaning |
|---|---|
| Memory mapped peripherial | register map base address |
| I2C peripherial | peripherial address on I2C bus |
| SPI peripherial | peripherial chip select line number |
| Memory | physical start address |
| Memory mapped flash | physical start address |
| Fixed flash partition | partition offset inside flash memory |

## Common properties

| Property | Type | Meaning | Use | Example
|---|---|---|---|---|
| compatible | string-array | vendor and device name | auto selection of drivers | st,lsm6dso |
| label | string | device name | reference in driver | I2C_0 |
| reg | (address, length)-array | device address | IO-MMap register/I2C slave address/CS line number | i2c@4003000 |
| status | string | node enabled | enable/disable device struct | "okay" / "disabled" |
| interrupts | interrupt-specifier-array | interrupt information | ? | ? |

The reg property is sometimes the same as the unit address above, but can
contain additional information.

## Alias and chosen nodes

```dts
/dts-v1/;

/ {
     chosen {
             zephyr,console = &uart0;
     };

     aliases {
             my-uart = &uart0;
     };

     soc {
             uart0: serial@12340000 {
                     ...
             };
     };
};
```

`my-uart` is an alias for `soc/serial@12340000`. Devices can then be addressed
by the alias instead of the node label.

## Overlays

Overlays can extend or modify existing board configurations. They are normal
DTS files that can be used

* for enabling peripherials that are disabled by default.
* for defining shields.

Overlays can be included by setting the `DTC_OVERLAY_FILE` variable or
automatically, if the overlay is named either `<board>.overlay` or
`app.overlay`.

If the following board.dts is used:

```dts
/ {
        soc {
                serial0: serial@40002000 {
                        status = "okay";
                        current-speed = <115200>;
                        /* ... */
                };
        };
};
```

The following overlay can modify the Serial speed:

```dts
/* Option 1 */
&serial0 {
     current-speed = <9600>;
};

/* Option 2 */
&{/soc/serial@40002000} {
     current-speed = <9600>;
};
```

## Bindings

Devietree bindings describe what information a node mst contain. It is similar
to DTD for XML.

```dts
/* Node in a DTS file */
bar-device {
     compatible = "foo-company,bar-device";
     num-foos = <3>;
};
```

```yml
# A YAML binding matching the node

compatible: "foo-company,bar-device"

properties:
  num-foos:
    type: int
    required: true
```

Bindings and DT nodes are matched using the `compatible` property.

## Usage

Given the following DT:

```dts
/ {
        soc {
                serial0: serial@40002000 {
                        status = "okay";
                        current-speed = <115200>;
                        /* ... */
                };
        };

        aliases {
                my-serial = &serial0;
        };

        chosen {
                zephyr,console = &serial0;
        };
};
```

If you want to use the serial0, you can use any of the following options in the
C code:

```c
/* Option 1: by node label */
#define MY_SERIAL DT_NODELABEL(serial0)

/* Option 2: by alias */
#define MY_SERIAL DT_ALIAS(my_serial)

/* Option 3: by chosen node */
#define MY_SERIAL DT_CHOSEN(zephyr_console)

/* Option 4: by path */
#define MY_SERIAL DT_PATH(soc, serial_40002000)

const struct device *uart_dev = DEVICE_DT_GET(MY_SERIAL);

if (!device_is_ready(uart_dev)) {
        /* Not ready, do not use */
        return -ENODEV;
}
```
