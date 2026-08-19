# Sentroxis Wazuh Deployment (v4.7.5)

This repository contains the Docker Compose deployment files for the **Wazuh All-in-One** stack, specifically configured for the Sentroxis project.

## Deployment Overview

This configuration deploys a single-node Wazuh stack including:
- **Wazuh Manager (v4.7.5)**: Configured with a **6 GB hard memory limit**.
- **Wazuh Indexer (v4.7.5)**: For security data storage and indexing.
- **Wazuh Dashboard (v4.7.5)**: Native web interface exposed on **HTTPS port 443**.

## Prerequisites

Before deploying, ensure your Ubuntu machine meets the following requirements:
- **Docker Engine** and **Docker Compose** installed.
- Minimum **8 GB RAM** (12 GB+ recommended for the host).
- Root or sudo privileges.

## Step-by-Step Deployment Instructions

### 1. Prepare the Host Environment
Wazuh Indexer requires the `vm.max_map_count` setting to be increased. Run the following command on your Ubuntu host:

```bash
sudo sysctl -w vm.max_map_count=262144
```

To make this change persistent across reboots, add `vm.max_map_count=262144` to `/etc/sysctl.conf`.

### 2. Clone the Repository
Pull this repository to your local machine:

```bash
git clone <repository-url>
cd <repository-directory>
```

### 3. Generate SSL Certificates
Wazuh components communicate over TLS. Generate the required self-signed certificates using the provided helper:

```bash
docker compose -f generate-indexer-certs.yml run --rm generator
```

### 4. Launch the Stack
Start the Wazuh deployment in the background:

```bash
docker compose up -d
```

### 5. Access the Web Interface
Once the containers are healthy (this may take 1-2 minutes), access the Wazuh Dashboard via your browser:

- **URL**: `https://<your-server-ip>`
- **Port**: 443 (Default HTTPS)
- **Default Credentials**:
  - **Username**: `admin`
  - **Password**: `SecretPassword` (It is highly recommended to change this immediately after login).

## Configuration Details

- **Memory Limit**: The Wazuh Manager container is restricted to a maximum of **6 GB RAM** to ensure host stability.
- **Network**: The dashboard is mapped to host port **443**, allowing standard HTTPS access.

## Troubleshooting
To view logs and monitor the deployment progress:

```bash
docker compose logs -f
```
