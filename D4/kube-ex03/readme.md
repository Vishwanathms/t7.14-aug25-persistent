# Kubernetes ConfigMap with Deployment and Rolling Updates

## 📌 Objective
Learn how to:
1. Use a **ConfigMap** to manage environment variables.
2. Attach a ConfigMap to a **Deployment**.
3. Perform a **rolling update** when the ConfigMap changes.

---

## 1. Create a ConfigMap

Define the environment variables in a `ConfigMap`:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-env-config
data:
  WELCOME_MSG: "Hello Kubernetes NGINX!"
  ENV: "Prod"
````

Apply it:

```sh
kubectl apply -f .
```

---

## 2. Deployment Using ConfigMap

Here is the Deployment manifest:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-env-demo
  labels:
    app: nginx-env-demo
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  selector:
    matchLabels:
      app: nginx-env-demo
  template:
    metadata:
      labels:
        app: nginx-env-demo
    spec:
      containers:
        - name: nginx
          image: vishwacloudlab/nginx-env-demo:latest
          ports:
            - containerPort: 80
          envFrom:
            - configMapRef:
                name: nginx-env-config
```

Apply it:

```sh
kubectl apply -f .
```

---

## 3. Update the ConfigMap

Suppose you want to change the message from **Prod** to **Staging**.

Edit the ConfigMap:

```sh
kubectl edit configmap nginx-env-config
```

Or re-apply a new version:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-env-config
data:
  WELCOME_MSG: "Hello Kubernetes NGINX!"
  ENV: "Staging"
```

Apply the change:

```sh
kubectl apply -f .
```

---

## 4. Rolling Update (Pods must restart)

Since environment variables from a ConfigMap are **loaded only at container start**, you need to restart the Pods to pick up the new values.

Run:

```sh
kubectl rollout restart deployment nginx-env-demo
```

Check rollout status:

```sh
kubectl rollout status deployment nginx-env-demo
```

View Pods:

```sh
kubectl get pods -l app=nginx-env-demo
```

---

## 5. Verify the Environment Variables

Exec into a Pod:

```sh
kubectl exec -it <pod-name> -- printenv | grep WELCOME_MSG
kubectl exec -it <pod-name> -- printenv | grep ENV
```

You should now see the updated values.

---

## ✅ Summary

* **ConfigMaps** store configuration outside containers.
* **Deployments** ensure rolling updates with zero downtime.
* **`kubectl rollout restart`** is required for Pods to reload ConfigMap values passed as environment variables.

```
