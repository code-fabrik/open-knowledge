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
