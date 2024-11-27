# NFS Configuration
**Follow this documentation to set up a NFS on __Centos__**.

This documentation guides you in setting up a NFS Server with one centos server.

##  Install NFS Sever.
```
sudo dnf install nfs-utils
```

#### Enable NFS service using below cmd
```
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
```
#### Starting NFS service using below cmd
```
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap


```
#### Allow firewall rule :
```
firewall-cmd --permanent --add-port=111/tcp
firewall-cmd --permanent --add-port=54302/tcp
firewall-cmd --permanent --add-port=20048/tcp
firewall-cmd --permanent --add-port=2049/tcp
firewall-cmd --permanent --add-port=46666/tcp
firewall-cmd --permanent --add-port=42955/tcp
firewall-cmd --permanent --add-port=875/tcp

```

#### Create NFS root DIR 
```
mkdir /var/ks 

```
#### Apply full Permissions to NFS root DIR :
```
chmod 777 /var/ks/
```
#### Export shared NFS directory :
```
vi /etc/exports

/var/ks/     *(rw,sync,no_root_squash,no_all_squash)

```


#### Restart NFS server service to referesh the configuration :
```
systemctl restart nfs-server

```

#### NFS Server Validation :

```
exportfs -rav

```

## Client Side Configuration 

##  Install NFS Sever on clinet .
```
yum install nfs-utils nfs-utils-lib
```

#### Enable NFS service using below cmd
```
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
```
#### Starting NFS service using below cmd
```
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

```
#### Clinet Mount Path
```

mount -t nfs nfs_serverip:/var/ks/ /var/data/ 
```

#### Clinet Installation in Ubuntu
```

sudo apt install nfs-common
sudo apt install cifs-utils
```

