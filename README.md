# Inception

## 📦 Description

Inception is a system administration project where I built a secure and modular web infrastructure using Docker and Docker Compose. The entire setup runs inside a virtual machine, and each service is containerized with a custom Dockerfile, without relying on pre-built images (except base Alpine/Debian).

The goal was to deploy a production-like environment to better understand container orchestration, secure service configuration, and scalable infrastructure design.

## 🧠 Skills Demonstrated

- Docker & Docker Compose
- System administration in Linux (networking, volumes, services)
- TLS/SSL configuration with NGINX
- Service orchestration & container networking
- Secret & environment variable management
- Monitoring & performance insights
- Bash scripting and Dockerfile optimization

## 🏗️ Infrastructure Overview

The architecture includes:

- 🔐 NGINX with HTTPS (TLSv1.2+)
- 📝 WordPress + PHP-FPM
- 🛢️ MariaDB
- 🌐 Custom Docker network
- 💾 Two Docker volumes:
  - Persistent database storage
  - WordPress website files

Each service is isolated in its own container, built from a custom Dockerfile using the latest stable Debian base (no `latest` tag).

## 🔐 Security & Configuration

- TLS/SSL is enforced on port 443 (via NGINX)
- Sensitive values (DB credentials, etc.) are managed through `.env` and Docker secrets
- Admin WordPress username excludes any "admin"-like term
- Secrets are ignored in Git and not hardcoded in any Dockerfile
- No infinite loops (`tail -f`, `sleep`, etc.) used in container entrypoints

## ⚙️ Mandatory Services

### NGINX

- Serves as reverse proxy and single entrypoint over HTTPS
- Custom TLS configuration
- Self-signed certs generated locally

### WordPress

- Installed and configured with PHP-FPM
- Connected to MariaDB
- Served through NGINX only

### MariaDB

- Database container for WordPress
- Pre-loaded database and users
- Persistent storage via volume

## ➕ Bonus Services

### Adminer

A lightweight database administration tool deployed in its own container for direct interaction with MariaDB.

### cAdvisor

A container monitoring tool providing real-time metrics and stats about all running containers via a web interface.

### FTP Server

Allows file upload/download access to the WordPress volume, fully containerized with secured configuration.

### Static Site — `inception`

A humorous nod to the project name, I deployed a small static website named `inception` (like the movie), built with HTML/CSS/JS. It runs in its own lightweight container.

### Redis

Used as a caching layer to optimize WordPress performance. Connected via environment configuration and dedicated volume.

## 🚀 Usage

```bash
# 1. Create and configure your .env file at the root of the project
cp srcs/.env .env
# Edit it to set your DOMAIN, MYSQL_USER, MYSQL_DATABASE, MYSQL_HOSTNAME, MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD, FTP_USER, FTP_PASSWORD.

# 2. Build and start all containers
make up

# 3. Stop and remove containers, volumes, and networks
make down

# 4. Full clean-up (if needed)
make fclean
```
