## Install Calico Network Plugin

```bash
# Install Tigera operator
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/tigera-operator.yaml

# Install custom resources
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/custom-resources.yaml
```

### Verification:
```bash
# Check Calico pods
kubectl get pods -n calico-system

# Verify node network status
kubectl get nodes -o wide
```


```bash
# Install Calico
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

-------------------------------------------------------------------------------------

## Flannel CNI Installation Guide

## Quick Installation
```bash
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
```

## Configuration Options

### Custom Pod Network CIDR
1. Download the manifest:
```bash
wget https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
```

2. Edit the `net-conf.json` section:
```yaml
net-conf.json: |
  {
    "Network": "10.244.0.0/16",  # Change to your desired CIDR
    "Backend": {
      "Type": "vxlan"             # Options: vxlan, host-gw, udp
    }
  }
```

3. Apply customized manifest:
```bash
kubectl apply -f kube-flannel.yml
```

## Verification
```bash
# Check Flannel pods (should be Running on all nodes)
kubectl get pods -n kube-system -l app=flannel

# Verify node status
kubectl get nodes
```
Expected output:
```
NAME         STATUS   ROLES           AGE   VERSION
node-1       Ready    control-plane   1h    v1.28.2
node-2       Ready    <none>          1h    v1.28.2
```

## Troubleshooting

### Common Issues
1. **Pods stuck in ContainerCreating**:
```bash
# Check Flannel logs
kubectl logs -n kube-system <flannel-pod-name>

# Verify network requirements
kubectl describe pod -n kube-system <flannel-pod-name>
```

2. **Firewall Configuration**:
```bash
# Ensure VXLAN traffic is allowed (UDP 8472)
sudo ufw allow 8472/udp
```

3. **CIDR Conflicts**:
```bash
# Check kubeadm init configuration
cat /etc/kubernetes/manifests/kube-controller-manager.yaml | grep cluster-cidr
```

## Key Notes
- **Default Pod CIDR**: `10.244.0.0/16`
- **Backend Options**: 
  - `vxlan` (default)
  - `host-gw` (better performance but requires layer 2 connectivity)
  - `udp` (for debugging only)
- **Compatibility**:
  - Remove other CNI plugins before installation
  - Works best with default kubeadm configurations