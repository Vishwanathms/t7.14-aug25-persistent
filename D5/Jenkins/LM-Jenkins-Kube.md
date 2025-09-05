## install kubectl on jenkins for a specific version

* login to jenkins 
```
 docker exec -it -u root jenkins /bin/bash 
```
* run the below command inside it
```
curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

```
* We have to delete the jenkins container and run with below command 

* For linux based 
```
docker run -d --name jenkins -p 8500:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v /home/<username>/.kube:/home/jenkins/.kube vishwacloudlab/jenkins:v2
```
* Windows based (Docker desktop)

```
docker run -d --name jenkins -p 8500:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -e DOCKER_HOST=tcp://host.docker.internal:2375 -v C:/Users/ADMIN/.kube:/home/jenkins/.kube -v C:/Users/ADMIN/.minikube:/home/jenkins/.minikube vishwacloudlab/jenkins:v2
```
```
docker run -d --name jenkins -p 8500:8080 -p 50000:50000 --user root -v jenkins_home:/var/jenkins_home -e DOCKER_HOST=tcp://host.docker.internal:2375 -v C:/Users/ADMIN/.kube:/home/jenkins/.kube -v C:/Users/ADMIN/.minikube:/home/jenkins/.minikube vishwacloudlab/jenkins:v2
```
* The above command would still have issuess accessing the minikube.
Clean Fix (Best of Both Worlds)

Run container as jenkins user, but make sure the kubeconfig files are readable by jenkins.

Here’s how:

1. On your Windows host

Make .kube and .minikube readable for everyone:

```
icacls C:\Users\<YourUser>\.kube\config /grant Everyone:(RX)
icacls C:\Users\<YourUser>\.minikube /T /grant Everyone:(RX)
```

This way, even if Jenkins runs as non-root, it can read the config and certs.