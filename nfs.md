#

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
## Client Side Configuration - Ubuntu

##  Install NFS Sever on clinet .
```
sudo apt update
sudo apt install nfs-common
```
