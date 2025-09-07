## install helm on jenkins container 

```
# Exec into Jenkins container
docker exec -it -u root jenkins /bin/bash

# Install dependencies
apt-get update && apt-get install -y curl apt-transport-https gnupg

# Download Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Verify
helm version

```
* On the windows machine (CMD), delete the deployment and service 
```
kubectl delete deployment python-deploy
kubectl delete svc python-service
```
* In the jenkins file replace the below 
```
        stage('Deploy (Run Container)') {
            steps {
                script {
                    sh 'docker run -d -p 5000:5000 --name jenkins_app $DOCKERHUB_USER/$IMAGE_NAME:latest'
                }
            }
        }
```
To 
```
        stage('Deploy to Kuberentes') {
            steps {
                script {
                    // sh 'kubectl config get-contexts'
                    // sh ' kubectl delete kube-files/python-deploy.yaml || true'
                    // sh ' kubectl apply -f kube-files/python-deploy.yaml'
                    sh 'helm delete nginx || true' 
                    sh 'helm install nginx ./python-app'
                }
            }

```
* complete code avaiable on below link
```
https://github.com/Vishwanathms/t7.14-py-jenkins.git

git@github.com:Vishwanathms/t7.14-py-jenkins.git
```