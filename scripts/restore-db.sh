#!/bin/bash

# 🐬 Restore database from SQL backup file
# Usage: ./scripts/restore-db.sh backups/db-backup-YYYY-MM-DD-HHMM.sql

if [ -z "$1" ]; then
  echo "❌ Please provide a .sql backup file to restore."
  echo "Usage: ./scripts/restore-db.sh backups/db-backup-*.sql"
  exit 1
fi

docker exec -i mysql_container /usr/bin/mysql -uwordpress_user -pwordpress_pass wordpress_db < "$1"

echo "✅ Database restored from $1"
