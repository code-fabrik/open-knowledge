# LPNP to Application Server Payloads

## Swisscom

```json
{
   "DevEUI_uplink":{
      "Time":"2016-09-27T12:26:59.886+02:00",
      "DevEUI":"FF000012FF000012",        // <-- Sender
      "FCntUp":"39",
      "ACKbit":"1",
      "ADRbit":"1",
      "MType":"2",
      "FCntDn":"13",
      "payload_hex":"000009f4",           // <-- Payload
      "mic_hex":"c9cea2c2",
      "Lrcid":"00000401",
      "LrrRSSI":"-105.000000",
      "LrrSNR":"-12.750000",
      "SpFact":"10",
      "SubBand":"G3",
      "Channel":"LC6",
      "DevLrrCnt":"1",
      "Lrrid":"29000128",
      "LrrLAT":"47.379795",
      "LrrLON":"8.527121",
      "Lrrs":{
         "Lrr":{
            "Lrrid":"29000128",
            "Chain":"0",
            "LrrRSSI":"-105.000000",
            "LrrSNR":"-12.750000",
            "LrrESP":"-117.974648"
         }
      },
      "CustomerID":"100000304",
      "CustomerData":{
         "alr":{
            "pro":"LORA/Generic",
            "ver":"1"
         }
      },
      "ModelCfg":"0",
      "AppSKey":"76bc91003738157fbe9f37b3ba9d677a",
      "InstantPER":"0.000000",
      "MeanPER":"0.015571"
   }
}
```

## The Things Network

```json
{
  "app_id": "my-app-id",
  "dev_id": "my-dev-id",
  "hardware_serial": "0102030405060708",  // <-- Sender
  "port": 1,
  "counter": 2,
  "is_retry": false,
  "confirmed": false,
  "payload_raw": "AQIDBA==",              // <-- Base64 payload 0x01020304
  "payload_fields": {},
  "metadata": {
    "time": "1970-01-01T00:00:00Z",
    "frequency": 868.1,
    "modulation": "LORA",
    "data_rate": "SF7BW125",
    "bit_rate": 50000,
    "coding_rate": "4/5",
    "gateways": [
      {
        "gtw_id": "ttn-herengracht-ams",
        "timestamp": 12345,
        "time": "1970-01-01T00:00:00Z",
        "channel": 0,
        "rssi": -25,
        "snr": 5,
        "rf_chain": 0,
        "latitude": 52.1234,
        "longitude": 6.1234,
        "altitude": 6
      },
    ],
    "latitude": 52.2345,
    "longitude": 6.2345,
    "altitude": 2
  },
  "downlink_url": "https://integrations.thethingsnetwork.org/ttn-eu/api/v2/down/my-app-id/my-process-id?key=ttn-account-v2.secret"
}
```
