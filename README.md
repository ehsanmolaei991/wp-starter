
# WordPress Docker Starter (Enterprise-Level)

This project provides a scalable and professional Docker-based development environment for WordPress. It includes structured scaffolding for custom themes and plugins, as well as a CI/CD workflow using GitHub Actions.

---

## 🚀 Quick Start

1. Copy the `.env.example` file to `.env`:
   ```bash
   cp .env.example .env
   ```

2. Start Docker services:
   ```bash
   docker-compose up -d
   ```

3. Access your WordPress site:
   - WordPress: http://localhost:8080
   - phpMyAdmin: http://localhost:8081

---

## 📁 Project Structure

- `wp-content/themes/custom-theme/`: Custom theme with minimal starter code
- `wp-content/plugins/custom-plugin/`: Custom plugin with sample functionality
- `.github/workflows/deploy.yml`: GitHub Actions workflow for CI/CD

---

## 🔁 CI/CD with GitHub Actions

This project includes a `deploy.yml` workflow in `.github/workflows/` which is triggered on every **push to the `main` branch**. It performs the following steps:

### Deployment Steps:

1. Checkout the latest code from the repository
2. Connect to your VPS via SSH using a private key
3. Copy files via `scp`
4. Execute remote commands:
   - Stop existing Docker services
   - Rebuild and restart services with `docker-compose up -d`

---

### ⚙️ Required GitHub Secrets

You need to add the following secrets to your GitHub repository under:

**Repository > Settings > Secrets > Actions**

| Secret Name  | Description                            |
|--------------|----------------------------------------|
| `HOST`       | Your server's IP address               |
| `USERNAME`   | SSH username (e.g., `root`)            |
| `SSH_KEY`    | The **private SSH key** (`id_rsa`)     |

---

### 🔐 SSH Key Generation & Server Access Setup

Generate a new SSH key on **your local machine** (not the server):

```bash
ssh-keygen -t rsa -b 4096 -C "github-deploy"
```

- Press Enter to accept the default location: `~/.ssh/id_rsa`
- This generates:
  - `id_rsa` → private key (used in GitHub Secrets)
  - `id_rsa.pub` → public key (added to your server)

Then on your **VPS server**, run:

```bash
mkdir -p ~/.ssh
nano ~/.ssh/authorized_keys
# Paste the contents of your id_rsa.pub file here and save
chmod 600 ~/.ssh/authorized_keys
```

Now your server is ready to accept deployments from GitHub.

---

### 🔐 Security Notes

- Never commit the `id_rsa` file to your repository.
- Use GitHub Secrets for storing credentials securely.
- You may restrict server SSH access to GitHub IPs for extra safety.

---

If you haven't yet purchased a VPS, you can follow the instructions later and come back to set up CI/CD once your server is ready.


---

## 💾 Backup Your Database

To take a database backup from your Docker-based WordPress instance:

1. Run this command:
   ```bash
   ./scripts/backup-db.sh
   ```

2. The backup will be saved in the `backups/` directory with a timestamped filename.

### 🔁 Optional Cronjob (on server):

To take automatic daily backups at 3 AM, add this line to your crontab:
```bash
0 3 * * * /home/username/wp-starter/scripts/backup-db.sh >> /home/username/wp-starter/backups/backup.log 2>&1
```



---

## 🗃️ Backup wp-content/uploads

To take a backup of your media files (uploads):

```bash
./scripts/backup-uploads.sh
```

The backup will be saved as a `.tar.gz` file in the `backups/` folder.

---

## ♻️ Restore Database from Backup

To restore a database backup:

```bash
./scripts/restore-db.sh backups/db-backup-YYYY-MM-DD-HHMM.sql
```

Make sure to replace the filename with your actual backup file.



---

## ♻️ Restore wp-content/uploads

To restore your uploads (media files) from a backup:

```bash
./scripts/restore-uploads.sh backups/uploads-backup-YYYY-MM-DD-HHMM.tar.gz
```

This will extract the backup and replace your `wp-content/uploads` folder with the contents of the archive.


---

## 🔐 .htaccess Security & Optimization

A sample `.htaccess` file is included under `wp-content/` with the following rules:

- `Options -Indexes`: Prevents listing of files in folders.
- Denies access to sensitive files like `wp-config.php` and `.htaccess`.
- Optionally restricts `wp-login.php` access to your IP.
- Enables **GZIP compression** for faster page loads.
- Enables **browser caching** for images, CSS, and JS to improve speed.

📍 Make sure your web server supports `.htaccess` (e.g., Apache). If using Nginx, similar rules must be applied in your server config.

---

## 🌐 Optional Nginx Reverse Proxy

If you want to run WordPress behind an **Nginx reverse proxy**, this project supports it via an optional file:

- `docker-compose.nginx.yml`: Defines the Nginx service
- `nginx/nginx.conf`: Custom reverse proxy configuration

### 🔧 How to run with Nginx:

```bash
# Run only WordPress + MySQL (default)
docker-compose up -d

# Run with Nginx as a reverse proxy (recommended for production setup)
docker-compose -f docker-compose.nginx.yml up -d
```

This will expose WordPress at:
- http://localhost:8085 (via Nginx)


---

## ⚙️ Advanced Nginx Configuration (Production Ready)

This project includes a fully customizable `nginx.conf` with:

- ✅ GZIP compression enabled
- ✅ Cache headers (`Cache-Control`, `Expires`)
- ✅ Rate limiting on login and sensitive paths
- ✅ Denial of access to sensitive files (`.env`, `.git`, `.ht*`)
- ✅ IP restriction on `/wp-login.php` (customizable)
- 🔐 Ready to be extended for HTTPS + Let's Encrypt

### How to use

```bash
docker-compose -f docker-compose.nginx.yml up -d
```

You can modify the Nginx rules inside `nginx/nginx.conf` to suit your needs.

🔄 HTTPS setup with Let's Encrypt will be scripted separately and documented soon.



---

## 🚀 Initial Setup Script

To simplify the first run of the project, use the script:

```bash
./scripts/init.sh
```

It will:
- Ensure `.env` exists
- Create `backups/` and `scripts/` folders if missing
- Make all `.sh` scripts executable
- Ask whether to launch with Nginx or not
- Run Docker containers accordingly
- Show access URLs and basic status info
