
#!/bin/bash
set -euo pipefail

MOUNTPOINT="/"
THRESHOLD=80
LOG="${HOME}/scripts/disk_alert.log"

# Get % usage of the mountpoint (portable parsing)
USAGE="$(df -P "$MOUNTPOINT" | awk 'NR==2 {gsub("%","",$5); print $5}')"

STAMP="$(date '+%F %T')"
MSG="Disk usage on $MOUNTPOINT is ${USAGE}% (threshold ${THRESHOLD}%)"

if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "$STAMP ⚠️  $MSG" | tee -a "$LOG"
  echo "Top space consumers on $MOUNTPOINT:" | tee -a "$LOG"
  # Show top 10 directories on the same filesystem (quick triage)
  du -x -h --max-depth=1 "$MOUNTPOINT" 2>/dev/null | sort -hr | head -n 10 | tee -a "$LOG"
  exit 1
else
  echo "$STAMP ✅ $MSG" | tee -a "$LOG"
fi
