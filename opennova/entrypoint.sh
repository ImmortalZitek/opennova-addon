#!/bin/sh
# ==============================================================================
# OpenNova HAOS Add-on — entrypoint wrapper
# Reads HAOS options from /data/options.json, exports as environment variables,
# then starts the OpenNova server via its original entrypoint.
# ==============================================================================
set -e

OPTIONS="/data/options.json"

echo "[OpenNova Add-on] Configuring environment..."

export PORT="${PORT:-80}"

if [ -f "$OPTIONS" ] && command -v jq >/dev/null 2>&1; then
    # TLS
    ENABLE_TLS=$(jq -r '.enable_tls // true' "$OPTIONS")
    export ENABLE_TLS="$ENABLE_TLS"

    # HA MQTT bridge (optional)
    HA_HOST=$(jq -r '.ha_mqtt_host // empty' "$OPTIONS")
    if [ -n "$HA_HOST" ]; then
        export HA_MQTT_HOST="$HA_HOST"
        export HA_MQTT_PORT=$(jq -r '.ha_mqtt_port // 1883' "$OPTIONS")
        export HA_MQTT_USER=$(jq -r '.ha_mqtt_user // empty' "$OPTIONS")
        export HA_MQTT_PASS=$(jq -r '.ha_mqtt_pass // empty' "$OPTIONS")
        echo "[OpenNova Add-on] HA MQTT bridge -> ${HA_MQTT_HOST}:${HA_MQTT_PORT}"
    fi
else
    export ENABLE_TLS="${ENABLE_TLS:-true}"
    echo "[OpenNova Add-on] Using default config (no options.json or jq)"
fi

echo "[OpenNova Add-on] Starting OpenNova server..."
echo "[OpenNova Add-on]   MQTT broker:  port 1883"
echo "[OpenNova Add-on]   HTTP API:     port ${PORT}"
echo "[OpenNova Add-on]   TLS:          ${ENABLE_TLS}"

# Hand off to the original OpenNova entrypoint
exec /app/docker-entrypoint.sh
