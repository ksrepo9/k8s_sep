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


