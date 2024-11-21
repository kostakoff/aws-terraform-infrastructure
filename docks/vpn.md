# VPN

In order to interact with you AWS infastructure you need vpn connection.
- OpenVPN file example
```
client
dev tun
proto udp
remote cvpn-endpoint-123456789.prod.clientvpn.ca-central-1.amazonaws.com 1194
remote-random-hostname
resolv-retry infinite
nobind
remote-cert-tls server
cipher AES-256-GCM
verb 3

reneg-sec 0

# custom 
route-nopull
route 10.0.0.0 255.0.0.0
dhcp-option DNS 10.10.0.2
dhcp-option DNS 8.8.8.8
dhcp-option DOMAIN myltd.lab

<ca>
</ca>

<cert>
</cert>

<key>
</key>

verify-x509-name server.local name
```