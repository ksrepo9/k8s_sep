# NFS Server Setup on Ubuntu

This guide provides step-by-step instructions to install and configure an NFS server on Ubuntu, allowing shared directories to be mounted on client machines.

---

## Prerequisites

- Ubuntu Server (20.04, 22.04, or later)
- Root or sudo privileges
- Basic knowledge of Linux command line

---

## Step 1: Update the System

```bash
sudo apt update && sudo apt upgrade -y
```

---

## Step 2: Install NFS Kernel Server

```bash
sudo apt install nfs-kernel-server -y
```

---

## Step 3: Create Shared Directory

Create a directory to be shared over NFS:

```bash
sudo mkdir -p /var/nfs/ks
```

Set appropriate permissions:

```bash
sudo chown nobody:nogroup /var/nfs/ks
sudo chmod 777 /var/nfs/ks
```

---

## Step 4: Configure Exports

Edit the `/etc/exports` file to specify shared directories and permissions:

```bash
sudo nano /etc/exports
```

Add the following line (modify IP addresses as needed):

```plaintext
/var/nfs/ks 192.168.29.0/24(rw,sync,no_subtree_check)
```

- Replace `192.168.29.0/24` with your client subnet or specific IPs.
- Use `*` to allow all clients (less secure).

Save and close the file.

---

## Step 5: Export Shared Directory

Apply the export configuration:

```bash
sudo exportfs -ra
```

Verify the export:

```bash
sudo exportfs -v
```

---

## Step 6: Restart NFS Service

```bash
sudo systemctl restart nfs-kernel-server
```

Ensure the service is active:

```bash
sudo systemctl status nfs-kernel-server
```


## Step 7: Mount NFS Share on Client

On the client machine, install NFS utilities:

```bash
sudo apt install nfs-common -y
```

Create a mount point:

```bash
sudo mkdir -p /mnt/nfs/general
```

Mount the NFS share:

```bash
sudo mount Client_IP:/var/nfs/ks /mnt/nfs/ks
```

Replace `Client_IP` with your server's IP address.

