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
![image](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/b3ea3d9f-ff77-4be4-b3b9-58705e84bd1d)

## Visit the Service via NodePort and the output is

![image](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/41e36917-d4ad-42e8-b6d1-a5583da73529)

Now access the URL from the browser on node port : 32724

![image](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/d8fc84a3-bb02-4194-98e8-9c276ae6a210)


## Now access the game using Ingress Resource

Currently Ingress resource doesn't have address assigned

![image](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/672c6567-9b49-4aad-9b66-570dc6aa8c8c)

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

