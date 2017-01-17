# Flight Controller

Parts:

1. Raspberry Pi Zero
1. Adafruit LoRa RFM9x (we use a 900mhz model)
1. GPS Module (we used a UBLOX NEO-6M)

## Enable SPI

Use raspi-config to enable SPI

## Wiring

### LoRa

| LoRa Pin | Pi Zero  | Pi Header |
|----------|----------|-----------|
| VCC      | 5v       | 1         |
| GND      | GND      | 6         |
| D0       | GPIO25   | 22        |
| SCK      | GPIO-11  | 23        |
| MISO     | GPIO-9   | 21        |
| MOSI     | GPIO-10  | 19        |
| CS       | GPIO-8   | 24        |
| RST      | GPIO-24  | 18        |

### GPS

| GPS | Pi Zero  | Pi Header |
|-----|----------|-----------|
| VCC | 3v       | 17        |
| GND | GND      | 6         |
| RX  | TX       | 8         |
| TX  | RX       | 10        |

### Setting up Forever script

1. npm i -g forever
1. crontab -u pi -e
1. Add this line

```
@reboot /usr/bin/sudo -H /usr/local/bin/forever start /home/pi/asan/asan-flight-js/forever/start.json
```
