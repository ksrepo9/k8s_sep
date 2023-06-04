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
sudo apt-get install docker-ce=5:19.03.12~3-0~ubuntu-bionic -y
sudo apt-mark hold docker-ce

```

## { Master - Worker } install kubeadm, kubelet, and kubectl on 2 Nodes.

#### Update the apt package index and install packages needed to use the Kubernetes apt repository:
```
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

```
#### Download the Google Cloud public signing key:
```
sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg

```

#### Add the Kubernetes apt repository:
```
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list


```

#### Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
```
sudo apt-get update
sudo apt-get install -y kubelet=1.24.9* kubeadm=1.24.9* kubectl=1.24.9* --allow-change-held-packages
sudo apt-mark hold kubelet kubeadm kubectl

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

swapoff -a


#### Verify nodes status  - { Master Node Config }
```
kubectl get nodes

```

