## Create kube-files and update the jenkinsfile

t7.14-py-jenkins/kube-files/python-deploy.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: python-deploy
spec:
  replicas: 2
  selector:
    matchLabels:
      app: python
  template:
    metadata:
      labels:
        app: python
    spec:
      containers:
        - name: python
          image: vishwacloudlab/jenkins-docker-lab:latest  # 👈 local image inside minikube docker
          ports:
            - containerPort: 5000
---
apiVersion: v1
kind: Service
metadata:
  name: python-service
spec:
  type: NodePort
  selector:
    app: python
  ports:
    - port: 5000
      targetPort: 5000
      nodePort: 30080
```
* update the jenkins 
```
        stage('Deploy to Kuberentes') {
            steps {
                script {
                    sh ' kubectl delete kube-files/python-deploy.yaml || true'
                    sh ' kubectl apply -f kube-files/python-deploy.yaml'
                }
            }
        }
```

* complete code avaiable on below link
```
https://github.com/Vishwanathms/t7.14-py-jenkins.git

git@github.com:Vishwanathms/t7.14-py-jenkins.git
```

