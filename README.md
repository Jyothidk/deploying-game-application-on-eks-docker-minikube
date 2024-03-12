# Deploying game application on EKS cluster

Prerequisites: Install kubectl, eksctl and aws cli and configure it on your system.

## Install EKS using Fargate

```
eksctl create cluster --name demo-cluster --region eu-central-1 --fargate
```

![alt text](1.png)

Update eks kubeconfig 
```
aws eks update-kubeconfig --name demo-cluster --region eu-central-1
```
## Create Fargate profile in name space game-2048

eksctl create fargateprofile \
    --cluster demo-cluster \
    --region eu-central-1 \
    --name alb-sample-app \
    --namespace game-2048

![2](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/173a7e18-1165-4d83-a1c4-04cc2bf1ad6b)

## Deploy the deployment, service and Ingress
```
kubectl apply -f manifests.yaml
```

![jyo-last](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/4e4deb76-6bd1-4d51-9fd6-b69c48691d73)


![4](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/caa32590-26ef-4e5b-a2e9-f3d1e520535c)

## Configure IAM OIDC provider
```
eksctl utils associate-iam-oidc-provider --cluster demo-cluster --approve
```
![5](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/c92d107a-6216-4b12-bc7e-48d3a1c4ccc3)

## How to setup alb add on

Download IAM policy

```
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json
```

Create IAM Policy

```
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json
```

![6](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/8f26feac-eba1-4c78-aa42-c5faf574903b)

Create service account and IAM Role

```
eksctl create iamserviceaccount \
  --cluster=demo-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::<your-aws-account-id>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```

![7-1](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/22969296-9905-4927-b9df-3f94cc96b03e)


## Deploy ALB controller

Add helm repo

```
helm repo add eks https://aws.github.io/eks-charts
```

Update the repo

```
helm repo update eks
```

Install

```
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \            
  -n kube-system \
  --set clusterName=demo-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=eu-central-1 \
  --set vpcId=vpc-0b031ee8ca5d57d1b
```

![8](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/dbffda08-f93a-47e7-a5e6-2c2c888f16ca)

Verify that the deployments are running.

```
kubectl get deployment -n kube-system aws-load-balancer-controller
```

![9](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/3db8a096-8cdd-46e6-85a8-92a8a308a3ca)

Now check the Ingress, it should be updated with address & this adress should be same as ALB DNS

![10-13](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/91789faf-fee7-4d2d-98ae-a9687d130f77)

![11](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/494ef27e-7d4f-469b-b132-9efb03039990)

Now open the address on the browser

![12](https://github.com/Jyothidk/Deploying-game-application-on-EKS/assets/127189060/f70f2b73-5c5f-46b0-80d8-3980bdd57c20)

