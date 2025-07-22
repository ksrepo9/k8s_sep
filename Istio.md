### **1. Verify Istio Installation**  
Ensure Istio is installed in your cluster. If not, install it using the official demo profile:  

```bash
istioctl install --set profile=demo -y
```  

### **2. Install Istio CRDs**  
If Istio is installed but Custom Resource Definitions (CRDs) are missing, apply them manually:  

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.18/manifests/charts/base/crds/crd-all.gen.yaml
```  

### **3. Check Istio Component Status**  
Confirm that all Istio components are running correctly in the `istio-system` namespace:  

```bash
kubectl get pods -n istio-system
```  
