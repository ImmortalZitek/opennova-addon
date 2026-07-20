FROM rvbcrs/opennova:latest

LABEL \
    io.hass.version="1.0.2" \
    io.hass.type="addon" \
    io.hass.arch="aarch64|amd64" \
    io.hass.name="OpenNova" \
    io.hass.description="Self-hosted Novabot cloud replacement"

# Install jq for reading HAOS options.json
# Base image is Alpine (not Debian) — use apk
RUN apk add --no-cache jq

# Our wrapper entrypoint reads HA config then calls the original /app/docker-entrypoint.sh
COPY entrypoint.sh /ha-entrypoint.sh
RUN chmod a+x /ha-entrypoint.sh

ENTRYPOINT ["/ha-entrypoint.sh"]
