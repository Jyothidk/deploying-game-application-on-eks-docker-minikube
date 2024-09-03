# Run game-2048 on Docker

A smaller docker version of 2048. 
2048 code is written in angular

## Build the image from the Docker file and run the container.

 ```
 git clone https://github.com/Jyothidk/deploying-game-application-on-eks-docker-minikube.git
 cd deploying-game-application-on-eks-docker-minikube/
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
