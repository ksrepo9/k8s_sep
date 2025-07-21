```markdown
# MetalLB Load Balancer Installation Guide

## 1. Installation Methods

### Option A: Manifest Installation (Recommended)
```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.12/config/manifests/metallb-native.yaml
```
**Components Installed:**
- Controller (Deployment)
- Speaker (DaemonSet)
- CRDs for configuration

### Option B: Helm Installation (Advanced Users)
```bash
helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb -n metallb-system --create-namespace
```

## 2. IP Address Pool Configuration

Create `ip-pool.yaml`:
```yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.29.100-192.168.29.200  # Replace with your unused IP range
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: l2-advert
  namespace: metallb-system
spec:
  ipAddressPools:
  - default-pool
```

Apply configuration:
```bash
kubectl apply -f ip-pool.yaml
```

## 3. Verification

Check MetalLB components:
```bash
kubectl get pods -n metallb-system
# Expected output:
# controller-xxxxxx   1/1     Running
# speaker-xxxxxx      1/1     Running (on each node)
```

Test with sample service:
```bash
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=LoadBalancer
kubectl get svc nginx -w  # Watch for EXTERNAL-IP assignment
```

## 4. Troubleshooting

### Common Issues:
1. **No EXTERNAL-IP assigned**:
   - Verify IP range is unused in your network
   - Check speaker pod logs:
     ```bash
     kubectl logs -n metallb-system -l app=metallb -c speaker
     ```

2. **Webhook errors**:
   ```bash
   kubectl delete validatingwebhookconfiguration metallb-webhook-configuration
   ```

3. **Pods not starting**:
   ```bash
   kubectl describe pod -n metallb-system <pod-name>
   ```
```