#!/bin/bash

# 📅 Generate a timestamp for the backup file
DATE=$(date +"%Y-%m-%d-%H%M")
BACKUP_DIR="./backups"
FILENAME="uploads-backup-$DATE.tar.gz"

# 🗂️ Ensure the backup directory exists
mkdir -p $BACKUP_DIR

# 📦 Backup the uploads folder from wp-content
tar -czvf $BACKUP_DIR/$FILENAME wp-content/uploads

echo "✅ wp-content/uploads backup created: $BACKUP_DIR/$FILENAME"
