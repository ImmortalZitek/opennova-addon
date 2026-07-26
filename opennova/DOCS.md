# OpenNova — Self-hosted Novabot Cloud Replacement

Run your Novabot N1000/N2000 completely local without depending on the Novabot cloud.

## What it does

This add-on runs the OpenNova server which includes:

- **MQTT Broker** (port 1883) — your mower and charging station connect here
- **Cloud API** (HTTP/HTTPS) — compatible with the official Novabot app
- **Home Assistant bridge** (optional) — auto-discovers mower entities via MQTT

## Setup

### 1. Install this add-on

Install from the add-on store after adding the repository.

### 2. Set up DNS redirect

Your mower needs to find this server when it looks up `mqtt.lfibot.com`.

**Recommended: Install the AdGuard Home add-on**

1. Go to **Settings → Add-ons → Add-on Store**
2. Install **AdGuard Home**
3. Open AdGuard Home web UI
4. Go to **Filters → DNS rewrites**
5. Add two entries:
   - `mqtt.lfibot.com` → your Home Assistant IP (e.g. `192.168.1.100`)
   - `app.lfibot.com` → your Home Assistant IP
6. In your router, set the DHCP DNS server to your Home Assistant IP

### 3. Restart your mower

Power cycle the mower and charging station. They will connect to your local OpenNova server via MQTT.

### 4. Verify connection

Open the OpenNova admin panel (sidebar link or `http://homeassistant.local:8280`) to see your mower's connection status.

### 5. (Optional) Home Assistant integration

To bridge mower data into Home Assistant:

1. Install the **Mosquitto broker** add-on (HA's MQTT broker)
2. In OpenNova add-on config, set:
   - **HA MQTT Host**: your HA IP
   - **HA MQTT Port**: 1883
   - **HA MQTT User/Pass**: your Mosquitto credentials
3. Restart the OpenNova add-on
4. Mower entities will auto-appear in Home Assistant

## Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 8280 | TCP | HTTP — API & admin panel |
| 8443 | TCP | HTTPS — for official Novabot app |
| 1883 | TCP | MQTT — mower & charger connection |

> **Note:** The mower connects to MQTT on port 1883 (standard). The HTTP ports are mapped to 8280/8443 to avoid conflicts with Home Assistant.

## Support

- OpenNova project: <https://github.com/rvbcrs/Novabot>
- This add-on wrapper: built for local use
