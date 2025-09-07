Here’s the **step-by-step updated guide with code** for **Docker Desktop**:

---

# 🚀 Setting up Argo CD on Docker Desktop Kubernetes

---

## 1. Enable Kubernetes in Docker Desktop

1. Open **Docker Desktop → Settings → Kubernetes**.
2. Check ✅ **Enable Kubernetes**.
3. Wait for the cluster to initialize.

👉 Verify:

```bash
kubectl get nodes
```

---

## 2. Create Namespace for Argo CD

```bash
kubectl create namespace argocd
```

---

## 3. Install Argo CD

Apply the official manifest:

```bash
kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

👉 Check pods:

```bash
kubectl get pods -n argocd
```

---

## 4. Expose Argo CD Server (Docker Desktop fix)

Since Docker Desktop doesn’t expose `ClusterIP` services outside, change the Argo CD server service type to `LoadBalancer`.

```bash
kubectl patch svc argocd-server -n argocd \
  -p '{"spec": {"type": "LoadBalancer"}}'
```

👉 Get the service details:

```bash
kubectl get svc -n argocd argocd-server
```

Example output:

```
NAME            TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)         AGE
argocd-server   LoadBalancer   10.96.20.10     localhost     80:30080/TCP,443:30443/TCP   5m
```

💡 On Docker Desktop, the `EXTERNAL-IP` is always `localhost`.

* Access Argo CD UI → **[https://localhost:30443](https://localhost:30443)**

---

## 5. Get Initial Admin Password

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d; echo
```

---

## 6. Login to Argo CD

### CLI Login

```bash
argocd login localhost:30443 --username admin --password <PASSWORD> --insecure
```

### Web UI Login

* URL: [https://localhost:30443](https://localhost:30443)
* Username: `admin`
* Password: (retrieved above)

---

## 7. Deploy Sample Application (Guestbook)

Create `application.yaml`:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  destination:
    namespace: default
    server: https://kubernetes.default.svc
  source:
    repoURL: https://github.com/argoproj/argocd-example-apps
    path: guestbook
    targetRevision: HEAD
  syncPolicy:
    automated: {}
```

Apply it:

```bash
kubectl apply -f application.yaml -n argocd
```

Check status:

```bash
kubectl get applications -n argocd
```

Then go to the **Argo CD Web UI** → You’ll see the **Guestbook app deployed**.

