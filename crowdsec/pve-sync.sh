#!/bin/sh
# Ensure dependencies are present
apk add --no-cache curl jq

echo "Checking for Proxmox IP Set 'crowdsec_bans'..."

# Step 0: Ensure the IP Set exists at the Datacenter level
# This prevents the '500 no such IPSet' error
curl -s -k -X POST -H "Authorization: PVEAPIToken=$PVE_TOKEN_ID=$PVE_TOKEN_SECRET" \
  -d "name=crowdsec_bans" \
  "https://localhost:${PVE_PORT:-8006}/api2/json/cluster/firewall/ipset" > /dev/null

while true; do
  echo "Starting Sync: $(date)"

  # 1. Fetch current active decisions from CrowdSec LAPI
  # Using the CROWDSEC_PORT variable passed from your compose file
  CS_BANS=$(curl -s -H "X-Api-Key: $BOUNCER_KEY" "http://localhost:${CROWDSEC_PORT:-8080}/v1/decisions" | jq -r '. // [] | .[].value // empty' | sort)

  # 2. Fetch current IPs from the Proxmox 'crowdsec_bans' IP Set
  PVE_BANS=$(curl -s -k -H "Authorization: PVEAPIToken=$PVE_TOKEN_ID=$PVE_TOKEN_SECRET" \
    "https://localhost:${PVE_PORT:-8006}/api2/json/cluster/firewall/ipset/crowdsec_bans" | jq -r '.data // [] | .[].cidr // empty' | sort)

  # 3. ADD Logic: New bans in CrowdSec that aren't in Proxmox yet
  for ip in $CS_BANS; do
    if ! echo "$PVE_BANS" | grep -q "$ip"; then
      echo "Adding $ip to Proxmox GUI..."
      curl -s -k -X POST -H "Authorization: PVEAPIToken=$PVE_TOKEN_ID=$PVE_TOKEN_SECRET" \
        -d "cidr=$ip" "https://localhost:${PVE_PORT:-8006}/api2/json/cluster/firewall/ipset/crowdsec_bans" > /dev/null
    fi
  done

  # 4. REMOVE Logic: IPs in Proxmox that are no longer in the CrowdSec list
  for pve_ip in $PVE_BANS; do
    if ! echo "$CS_BANS" | grep -q "$pve_ip"; then
      echo "Removing expired ban $pve_ip from Proxmox GUI..."
      curl -s -k -X DELETE -H "Authorization: PVEAPIToken=$PVE_TOKEN_ID=$PVE_TOKEN_SECRET" \
        "https://localhost:${PVE_PORT:-8006}/api2/json/cluster/firewall/ipset/crowdsec_bans/$pve_ip" > /dev/null
    fi
  done

  echo "Sync complete. Sleeping 5 minutes..."
  sleep 300
done
