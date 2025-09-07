#!/bin/bash
set -euo pipefail

SOURCE_DIR="${HOME}/notes"     # change this if you want
DEST_DIR="${HOME}/backups"
TS="$(date +%F-%H%M%S)"
ARCHIVE="${DEST_DIR}/backup-${TS}.tar.gz"
LOG="${HOME}/scripts/backup.log"

mkdir -p "$DEST_DIR"

echo "$(date '+%F %T') Starting backup of ${SOURCE_DIR} -> ${ARCHIVE}" | tee -a "$LOG"

# Create archive; exclude the destination dir itself just in case
tar -czf "$ARCHIVE" --exclude="$DEST_DIR" -C / "${SOURCE_DIR#/}"

echo "$(date '+%F %T') ✅ Backup complete: ${ARCHIVE}" | tee -a "$LOG"

