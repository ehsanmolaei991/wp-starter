#!/bin/bash

# ♻️ Restore wp-content/uploads from backup .tar.gz file
# Usage: ./scripts/restore-uploads.sh backups/uploads-backup-*.tar.gz

if [ -z "$1" ]; then
  echo "❌ Please provide a .tar.gz backup file to restore."
  echo "Usage: ./scripts/restore-uploads.sh backups/uploads-backup-*.tar.gz"
  exit 1
fi

# 📁 Extract uploads backup to the appropriate directory
tar -xzvf "$1" -C .

echo "✅ wp-content/uploads has been restored from $1"
