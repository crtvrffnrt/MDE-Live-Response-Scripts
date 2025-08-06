#!/bin/bash
echo "Checking outbound blocks to TCP port 443..."
echo -e "\n[iptables] Rules blocking OUTBOUND port 443:"
sudo iptables -S OUTPUT | grep -E "DROP|REJECT" | grep -- "-p tcp" | grep -- "--dport 443"
if command -v nft &>/dev/null; then
    echo -e "\n[nftables] Rules blocking OUTBOUND port 443:"
    sudo nft list ruleset | grep -i -A 3 "chain output" | grep -iE "tcp dport 443.*(drop|reject)"
else
    echo -e "\n[nftables] Not installed or not in use."
fi
echo -e "\n[ufw] Rules status and possible blocks:"
sudo ufw status numbered | grep -i "443"
echo -e "\n[Connectivity Test] Attempting connection to google.com:443..."
timeout 5 bash -c '</dev/tcp/google.com/443' && echo "Port 443 reachable." || echo "Port 443 appears blocked."
echo -e "\n[Connectivity Test] Attempting connection to 68.219.176.136:443..."
timeout 5 bash -c '</dev/tcp/68.219.176.136/443' && echo "Port 443 reachable (68.219.176.136)." || echo "Port 443 appears blocked (68.219.176.136)."
