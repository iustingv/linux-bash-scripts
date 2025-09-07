#!/bin/bash
set -euo pipefail

TARGET_HOST="8.8.8.8"      # ICMP ping (Google DNS)
TARGET_URL="https://google.com"  # HTTP check
LOG="${HOME}/scripts/health_check.log"

echo "==== EC2 Health Check $(date '+%F %T') ====" | tee -a "$LOG"

# Internet via ping (ICMP). Some networks block ICMP; that’s why we also do HTTP below.
if ping -c 2 -W 2 "$TARGET_HOST" > /dev/null 2>&1; then
  echo "Ping ($TARGET_HOST): ✅ OK" | tee -a "$LOG"
else
  echo "Ping ($TARGET_HOST): ❌ FAIL" | tee -a "$LOG"
fi

# HTTP reachability
if curl -s --max-time 4 -I "$TARGET_URL" >/dev/null; then
  echo "HTTP ($TARGET_URL): ✅ OK" | tee -a "$LOG"
else
  echo "HTTP ($TARGET_URL): ❌ FAIL" | tee -a "$LOG"
fi

# Uptime
echo -n "Uptime: " | tee -a "$LOG"
uptime | tee -a "$LOG"

echo | tee -a "$LOG"

