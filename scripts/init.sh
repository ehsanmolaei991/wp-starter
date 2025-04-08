#!/bin/bash

echo "🚀 Starting Initial Setup for WordPress Docker Project..."

# Step 1: Check .env file
if [ ! -f .env ]; then
  echo "📄 .env not found. Creating from .env.example..."
  cp .env.example .env
else
  echo "✅ .env file already exists."
fi

# Step 2: Create necessary folders
mkdir -p backups scripts

# Step 3: Make all scripts executable
chmod +x scripts/*.sh

# Step 4: Ask for Nginx inclusion
read -p "🧩 Do you want to include Nginx reverse proxy? (y/n): " use_nginx

if [ "$use_nginx" == "y" ]; then
  echo "📦 Starting Docker Compose with Nginx..."
  docker-compose -f docker-compose.nginx.yml up -d
else
  echo "📦 Starting Docker Compose without Nginx..."
  docker-compose up -d
fi

# Step 5: Test if WordPress container is running
sleep 3
if docker ps | grep wordpress_container > /dev/null; then
  echo "✅ WordPress container is running."
  echo "🌐 Access your site at: http://localhost:80"
else
  echo "❌ WordPress container not running. Please check docker logs."
fi

# Step 6: Optional Nginx port
if [ "$use_nginx" == "y" ]; then
  echo "🌐 Access via Nginx: http://localhost:8085"
fi

echo "🎉 Setup complete."
