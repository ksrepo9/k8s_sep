# Install Kubernetes Cluster using kubeadm
Follow this documentation to set up a Kubernetes cluster on __Ubuntu__.

This documentation guides you in setting up a cluster with one master node and one worker node.

## { Master - Worker } Install Docker on 2 Nodes.

#### Update the apt package index and install packages to allow apt to use a repository over HTTPS:
```
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

```
#### Add Docker’s official GPG key:
```
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

```
#### Use the following command to set up the repository:
```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

```

#### Install Docker Engine
```
sudo apt-get update
sudo apt-get install docker.io
sudo apt-mark hold docker-ce

```

## { Master - Worker } install kubeadm, kubelet, and kubectl on 2 Nodes.

#### Update the apt package index and install packages needed to use the Kubernetes apt repository:
```
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

```
#### Download the Google Cloud public signing key:
```
# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

```

#### Add the Kubernetes apt repository:
```
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

```

#### Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
```
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

```
#### Enable the kubelet service before running kubeadm:
```
sudo systemctl enable --now kubelet
```

#### Restart docker and kubelet

```
systemctl restart kubelet
systemctl daemon-reload

```

#### Troubleshooting steps

```
cd /etc/containerd
rm -rf *;
systemctl restart containerd

```

#### Kubernetes Master Node Configuration - { Master Node Config }

```
sudo kubeadm init

```

#### kubeconfig update - { Master Node Config }
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

```
#### Worker Node Join Token - { Master Node Config }
```
sudo kubeadm token create --print-join-command

```

#### K8S Cluster CNI Configuration: - { Master Node Config }
```
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

```
```
swapoff -a
kubeadm reset --force
```

#### Verify nodes status  - { Master Node Config }
```
kubectl get nodes

```


Here's a concise `git.md` documenting the etcd backup/clear procedure:

```markdown
# ETCD Data Management

## Backup and Clear `/var/lib/etcd` (For New Clusters)

Use this procedure when initializing a new Kubernetes cluster or when existing etcd data is no longer needed.

### Steps:

1. **Backup existing data**:
   ```bash
   sudo mv /var/lib/etcd /var/lib/etcd.backup
   ```

2. **Create fresh directory**:
   ```bash
   sudo mkdir /var/lib/etcd
   ```

3. **Set proper permissions**:
   ```bash
   sudo chmod 700 /var/lib/etcd
   ```

4. **Initialize cluster**:
   ```bash
   sudo kubeadm init --ignore-preflight-errors=DirAvailable--var-lib-etcd
   ```

### Notes:
- This will permanently delete previous etcd data
- For production clusters with existing data, consider etcd snapshot restoration instead
- Always verify backups before deletion

> Warning: Only use this for new clusters or when you intentionally want to wipe etcd data.
```

