##
* run the below command inside the folder
```
kubectl apply -f .
kubectl get pods

kubectl get svc

minikube service nginx-svc
```

## Deployment 
* delete the pod 
```
kubectl delete pod nginx-pod1

kubectl apply -f deployment.yaml

kubectl get pods

kubectl get deployment
kubectl delete pod "pod id"

```
* check the pods again to see a new pod



