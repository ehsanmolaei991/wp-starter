#!/bin/bash

# 📅 Generate a timestamp for the backup file
DATE=$(date +"%Y-%m-%d-%H%M")
BACKUP_DIR="./backups"
FILENAME="db-backup-$DATE.sql"

# 🗂️ Ensure the backup directory exists
mkdir -p $BACKUP_DIR

# 🐬 Backup MySQL database from Docker container
# Replace mysql_container, username, password, and database name if changed
docker exec mysql_container /usr/bin/mysqldump -uwordpress_user -pwordpress_pass wordpress_db > $BACKUP_DIR/$FILENAME

echo "✅ Database backup created: $BACKUP_DIR/$FILENAME"
