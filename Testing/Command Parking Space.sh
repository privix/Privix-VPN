echo "Starting OpenVPN..."
systemctl -f enable openvpn@openvpn-server
systemctl restart openvpn@openvpn-server


