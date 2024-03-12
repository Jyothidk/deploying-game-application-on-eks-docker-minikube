# Run game-2048 on Docker

A smaller docker version of 2048. 
2048 code is written in angular

## Build the image from the Docker file and run the container.

 ```
 git clone https://github.com/Jyothidk/Deploying-game-application-on-EKS.git
 cd Deploying-game-application-on-EKS/
 docker build -t jyothi5566/game-2048:v1 .
 docker run -d -p 8080:80 --name web jyothi5566/game-2048:v1
```

## Run the docker container by pulling the image directly

```
docker run -d -p 8080:80 --name web jyothi5566/game-2048:v1
```
 
## Access the game

    http://127.0.0.1:8080 or 
    http://localhost:8080
    
------------------------------------------------------------------------------------------
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

![image](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/4c9392e8-c4f2-4462-8002-bc74ccb6509e)

Now check the Ingress resource , it should be assigned with address

![image](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/07f788f1-10a4-4c13-b396-726a6979c10b)

Now access the address on port 80

![image](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/9f88e76f-8dec-406e-bb71-62c44d689b2b)

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

