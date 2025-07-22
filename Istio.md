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


---

## **Traffic Splitting (Optional)**  
To control traffic distribution between **stable** and **canary** versions, you can use:  
- An **Ingress controller** (e.g., Nginx Ingress)  
- A **service mesh** (e.g., Istio)  

### **Example: Traffic Splitting with Istio**  
The following `VirtualService` configures a **90/10 traffic split** between stable and canary deployments:  

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: my-app-virtual-service
spec:
  hosts:
    - my-app.example.com
  http:
    - route:
        - destination:
            host: my-app-stable
            subset: stable
          weight: 90
        - destination:
            host: my-app-canary
            subset: canary
          weight: 10
```

### **How It Works**  
- **Stable Deployment (`my-app-stable`)** receives **90% of traffic** (default).  
- **Canary Deployment (`my-app-canary`)** receives **10% of traffic** (test phase).  

### **Next Steps**  
- **If the canary performs well**, gradually shift traffic (e.g., 50/50 → 100% canary).  
- **If issues arise**, roll back by reducing canary traffic to **0%** with minimal impact.  

