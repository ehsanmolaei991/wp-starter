
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

Just purchase a VPS, follow the instructions and come back to set up CI/CD once your server is ready.
