# PNB Connect Dockerfile
FROM debian:bullseye

LABEL maintainer="PNB Project"
LABEL description="PNB Connect - Tor + VPN Gateway"

# Install basics
RUN apt-get update && apt-get install -y \
    tor \
    openvpn \
    curl iptables \
    && rm -rf /var/lib/apt/lists/*

# Copy VPN config (you’ll need to mount your .ovpn file later)
COPY vpn.ovpn /etc/openvpn/config.ovpn

# Tor config (basic routing)
COPY torrc /etc/tor/torrc

# Forward traffic through Tor + VPN
CMD openvpn --config /etc/openvpn/config.ovpn & tor
