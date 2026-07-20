FROM rvbcrs/opennova:latest

LABEL \
    io.hass.version="1.0.0" \
    io.hass.type="addon" \
    io.hass.arch="aarch64|amd64" \
    io.hass.name="OpenNova" \
    io.hass.description="Self-hosted Novabot cloud replacement"

# Install jq for reading HAOS options.json
# Try both Alpine (apk) and Debian (apt) package managers
RUN (apk add --no-cache jq 2>/dev/null) || \
    (apt-get update && apt-get install -y --no-install-recommends jq && rm -rf /var/lib/apt/lists/*) || \
    echo "WARN: jq not available, will use defaults"

# Entrypoint wrapper — sets env vars from HAOS config, then runs original CMD
COPY entrypoint.sh /ha-entrypoint.sh
RUN chmod a+x /ha-entrypoint.sh

ENTRYPOINT ["/ha-entrypoint.sh"]
