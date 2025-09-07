# **Auto-Deploy with Argo CD when Manifests are Updated**

---

## 1. Understand the Workflow

1. **Git Repository** contains your Kubernetes manifests (YAMLs / Helm / Kustomize).
2. Developer pushes a change → merged into the main branch.
3. **Argo CD detects the change** in the Git repo.
4. Argo CD **syncs automatically** (if auto-sync is enabled).
5. The application is updated in the Kubernetes cluster.

👉 No manual `kubectl apply` or Jenkins job needed — Argo CD watches Git and applies changes.

---

## 2. Configure Argo CD Application with Auto-Sync

Here’s a sample **Argo CD Application CRD** (`application.yaml`):

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/argoproj/argocd-example-apps
    targetRevision: HEAD   # Always track the latest commit
    path: guestbook
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true       # Remove resources not in Git
      selfHeal: true    # Fix drift if manual changes are made
    syncOptions:
    - CreateNamespace=true
```

---

## 3. Apply the Application

```bash
kubectl apply -f application.yaml -n argocd
```

---

## 4. Enable Auto-Sync (if not defined in YAML)

If you already created the app without auto-sync, you can enable it via CLI:

```bash
argocd app set guestbook --sync-policy automated
```

---

## 5. Test Auto-Deployment

1. Update your Kubernetes manifest in Git (e.g., change replicas in `deployment.yaml`):

   ```yaml
   replicas: 5
   ```
2. Commit and push:

   ```bash
   git commit -am "Scale replicas to 5"
   git push origin main
   ```
3. Argo CD will detect the change and automatically apply it.

👉 Check app status:

```bash
argocd app get guestbook
kubectl get pods -n default
```

---

## 6. (Optional) Webhooks for Faster Sync

By default, Argo CD polls the Git repo every **3 minutes**. To speed this up, configure a **Git webhook** (GitHub/GitLab/Bitbucket):

* Add webhook in your repo pointing to Argo CD API:

  ```
  https://argocd-server.<domain>/api/webhook
  ```
* Now Argo CD reacts instantly on push events.

---

## ✅ Summary

To auto-deploy when manifests are updated:

1. Define an Argo CD Application with **syncPolicy.automated**.
2. Enable **prune** (clean up deleted resources) and **selfHeal** (fix drift).
3. Push changes to Git → Argo CD applies them automatically.
4. (Optional) Use **webhooks** for near real-time sync.

