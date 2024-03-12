# Run game-2048 on Minikube

Now we have docker image for game-2048 in Docker hub. 
Start minikube. Maku sure your kubernetes cluster is running.
    
## Deploy the deployment, service and Ingress 

```
 kubectl apply -f manifests_minikube.yaml
```
![a1](https://github.com/Jyothidk/deploying-game-application-on-eks-docker-minikube/assets/127189060/2c999251-3617-4ae7-b49c-61d5bac93625)

## Visit the Service via NodePort and the output is

![a2](https://github.com/Jyothidk/deploying-game-application-on-eks-docker-minikube/assets/127189060/cf8438a2-6670-4466-afa3-a5973b51c01b)

Now access the URL from the browser on node port : 32724

![a3](https://github.com/Jyothidk/deploying-game-application-on-eks-docker-minikube/assets/127189060/d61ab862-1e3e-4c9f-80be-f7010b1a2bac)



## Now access the game using Ingress Resource

Currently Ingress resource doesn't have address assigned

![a4](https://github.com/Jyothidk/deploying-game-application-on-eks-docker-minikube/assets/127189060/5365cd12-f4cf-423e-8a9e-55cfa7b55a42)

Now deploy the Nginx ingress controller on minikube

To enable the NGINX Ingress controller, run the following command

```
 minikube addons enable ingress
```
Verify that the NGINX Ingress controller is running

```
 kubectl get pods -n ingress-nginx
```

![a5](https://github.com/Jyothidk/deploying-game-application-on-eks-docker-minikube/assets/127189060/d33dd589-71bb-4dfe-9c40-54d611251033)

Now check the Ingress resource , it should be assigned with address

![a6](https://github.com/Jyothidk/deploying-game-application-on-eks-docker-minikube/assets/127189060/fae6c407-a727-4563-b6d9-7fd94802c792)

Now access the address on port 80

![a7](https://github.com/Jyothidk/deploying-game-application-on-eks-docker-minikube/assets/127189060/5df0c03c-0348-4977-bfc9-e9338419b8c0)


## Cleanup the resources

```
 minikube addons disable ingress
```
```
 kubectl delete -f manifests_minikube.yaml
```
```
 minikube stop
```


