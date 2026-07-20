FROM rvbcrs/opennova:latest

LABEL \
    io.hass.version="1.0.1" \
    io.hass.type="addon" \
    io.hass.arch="aarch64|amd64" \
    io.hass.name="OpenNova" \
    io.hass.description="Self-hosted Novabot cloud replacement"

# Install jq for reading HAOS options.json
# The base image is Node 20 on Debian, so use apt
RUN apt-get update && apt-get install -y --no-install-recommends jq && rm -rf /var/lib/apt/lists/*

# Our wrapper entrypoint reads HA config then calls the original /app/docker-entrypoint.sh
COPY entrypoint.sh /ha-entrypoint.sh
RUN chmod a+x /ha-entrypoint.sh

ENTRYPOINT ["/ha-entrypoint.sh"]
