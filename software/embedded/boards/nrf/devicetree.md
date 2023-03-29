# DeviceTree

## Project config

The `prj.conf` file defines what libraries and stacks are required, independent of the board:

<kbd>prj.conf</kbd>
```dt
CONFIG_NETWORKING=y
CONFIG_NET_IPV4=y
CONFIG_NET_IPV6=n
CONFIG_NET_LOG=y
CONFIG_MAIN_STACK_SIZE=4096
CONFIG_TINYCBOR=y
```

## Board config

The `%board%.conf` define board specific libraries and components (SPI, I2C, Ethernet) and is board dependent:

<kbd>%board%.conf</kbd>
```dt
CONFIG_WIFI=y
CONFIG_NET_DHCPV4=y
CONFIG_ESP32_WIFI_STA_AUTO=y
```

## Board devicetree overlay

The `%board%.overlay` contains a device tree overlay and defines what optional components are attached and is board dependent:

<kbd>%board%.overlay</kbd>
```dt
&i2c1 {
  bme280@76 {
    compatible = "bosch,bme280";
    reg = <0x76>;
    label = "BME280_I2C";
  };
};

/ {
  leds {
    compatible = "gpio-leds";

    blue_led: led_0 {
      gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
      label = "Onboard LED 0";
    };

    green_led: led_1 {
      gpios = <&gpio0 19 GPIO_ACTIVE_LOW>;
      label = "Green LED";
    };
  };

  buttons {
    compatible = "gpio-keys";
    button0: button_0 {
      gpios = <&gpio0 12 (GPIO_PULL_UP | GPIO_ACTIVE_LOW)>;
      label = "Switch 1";
    };
  };

  aliases {
    led0 = &blue_led;
    led1 = &green_led;
    sw0 = &button0;
  };
};
```

The overlay abstracts away the hardware location. Whenever led0 is enabled, the LED turns on, independent of the board.

## Swapping sensors

To swap two sensors, two changes need to be made:

* replace <kbd>board.overlay</kbd>, to tell the compiler on what peripherial to find what component
* replace <kbd>prj.conf</kbd> to enable the new sensors library

## Examples

### Adding LIS2DH to Zephyr

https://github.com/circuitdojo/nrf9160-feather-examples-and-drivers/blob/v2.2.x/samples/accelerometer/src/main.c

<kbd>prj.conf</kbd>
```dt
# Protocols
CONFIG_I2C=y

# Accelerometer
CONFIG_SENSOR=y
CONFIG_LIS2DH=y
CONFIG_LIS2DH_TRIGGER_GLOBAL_THREAD=y
```

<kbd>nrf9160feather.overlay</kbd>
```dt
&i2c1 {
  lis2dh@18 {
    compatible = "st,lis2dh";
    label = "LIS2DH";
    reg = <0x18>;
    irq-gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>, <&gpio0 30 GPIO_ACTIVE_HIGH>;
    disconnect-sdo-sa0-pull-up;
  };
};
```

<kbd>main.c</kbd>

Device load

```c
const struct device *sensor = DEVICE_DT_GET(DT_INST(0, st_lis2dh)); // device binding, aka "compatible"

if(sensor == NULL || !defice_is_ready(sensor)) {
  printf("Could not get %s device\n", DT_LABEL(DT_INST(0, st_lis2dh)));
  return;
}
```

Trigger struct (internal)

```c
struct sensor_trigger {
  enum sensor_trigger_type type;
  enum sensor_channel chan;
};
```

Configure trigger

```c
struct sensor_trigger trig;

trig.type = SENSOR_TRIG_DATA_READY;
trig.chan = SENSOR_CHAN_ACCEL_XYZ;

rc = sensor_trigger_set(sensor, &trig, trigger_handler);
if(rc != 0) {
  printf("Failed to set trigger: %d\n", rc);
  return rc;
}
```

Configure threshold trigger

```c
struct sensor_value attr;
int rc;

attr.val1 = 0;
attr.val2 = (int32_t)(SENSOR_G * 1.5);

rc = sensor_attr_set(sensor, SENSOR_CHAN_ACCEL_XYZ, SENSOR_ATTR_SLOPE_TH, &attr);
if(rc < 0) {
  printf("Cannot set slope threshold.");
  return rc;
}

trig.type = SENSOR_TRIG_DELTA;
trig.chan = SENSOR_CHAN_ACCEL_XYZ;

rc = sensor_trigger_set(sensor, &trig, trigger_handler);
if(rc != 0) {
  printf("Failed to set trigger: %d\n", rc);
  return rc;
}
```

Sensor value struct (internal)

```c
struct sensor_value {
  int32_t val1; // int part
  int32_t val2; // decimal part
}
```

Trigger handler

```c
int64_t uptime = k_uptime_get();

if(uptime > (last_trigger + m_config.trigger_interval * MSEC_PER_SEC) || last_trigger == 0) {
  APP_EVENT_MANAGER_PUSH(APP_EVENT_MOTION_EVENT);
  last_trigger = uptime;
}
```

Fetching values

```c
int err;
struct sensor_value val[3];

err = sensor_sample_fetch_chan(sensor, SENSOR_CHAN_ACCEL_XYZ);
if(err) {
  LOG_ERR("Unable to fetch data. Err: %i", err);
  return err;
}

err = sensor_channel_get(sensor, SENSOR_CHAN_ACCEL_XYZ, val);
if(err) {
  LOG_ERR("Unable to get data. Err: %i", err);
  return err;
}
```