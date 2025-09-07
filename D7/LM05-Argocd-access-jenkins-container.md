# **Install Argo CD CLI in Jenkins Docker Container**

---

## 1. Exec into the Jenkins Container

If your Jenkins is running as a container:

```bash
docker exec -it <jenkins_container_name> bash
```

👉 Replace `<jenkins_container_name>` with your container name, e.g.:

```bash
docker exec -it jenkins bash
```

---

## 2. Install Required Tools

Ensure `curl` and `unzip` are installed. Inside the container:

```bash
apt-get update && apt-get install -y curl unzip
```

---

## 3. Download Argo CD CLI

```bash
curl -sSL -o /usr/local/bin/argocd \
  https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
```

---

## 4. Make it Executable

```bash
chmod +x /usr/local/bin/argocd
```

---

## 5. Verify Installation

```bash
argocd version --client
```

Expected output (example):

```
argocd: v2.9.3+1234567
```

---

## 6. Use in Jenkins Pipelines

Now inside your Jenkins pipeline (`Jenkinsfile`), you can use `argocd` commands, for example:

```groovy
pipeline {
    agent any
    stages {
        stage('Deploy with Argo CD') {
            steps {
                sh '''
                  argocd login localhost:30443 \
                    --username admin \
                    --password $ARGOCD_PASSWORD \
                    --insecure

                  argocd app sync guestbook
                  argocd app wait guestbook --health
                '''
            }
        }
    }
}
```

Here, `$ARGOCD_PASSWORD` can be stored securely in Jenkins credentials.

---

✅ With this setup, Jenkins can now **trigger Argo CD deployments** as part of your CI/CD pipeline.

