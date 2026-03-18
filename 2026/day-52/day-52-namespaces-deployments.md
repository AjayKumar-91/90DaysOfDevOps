# Task 1: Explore Default Namespaces

### Kubernetes comes with built-in namespaces. List them:

kubectl get namespaces


### You should see at least:

#### default — where your resources go if you do not specify a namespace

#### kube-system — Kubernetes internal components (API server, scheduler, etc.)

#### kube-public — publicly readable resources

#### kube-node-lease — node heartbeat tracking

### Check what is running inside kube-system:

kubectl get pods -n kube-system


<img width="1263" height="421" alt="image" src="https://github.com/user-attachments/assets/270a7b69-b197-4b4b-9259-5a6306b70bb7" />

### Verify:

Count how many pods are running. These are core control-plane components — do not modify them.


# 2. Creating Custom Namespaces

### Create dev and staging namespaces:

kubectl create namespace dev

kubectl create namespace staging

kubectl get namespaces

### You can also create a namespace from a manifest:

kubectl apply -f namespace.yaml

### Now run a pod in a specific namespace:

kubectl run nginx-dev --image=nginx:latest -n dev

kubectl run nginx-staging --image=nginx:latest -n staging

### List pods across all namespaces:

kubectl get pods -A

<img width="1615" height="778" alt="image" src="https://github.com/user-attachments/assets/36fde7d3-723d-477e-9252-b45aba7a6ee8" />

### Verify: Running kubectl get pods without -n shows only the default namespace. -A shows all.

# Task 3: Create Your First Deployment

A Deployment tells Kubernetes: "I want X replicas of this Pod running at all times." If a Pod crashes, the Deployment controller recreates it automatically.

#### Create a file nginx-deployment.yaml:

kubectl apply -f nginx-deployment.yaml

### Apply it:

kubectl apply -f nginx-deployment.yaml

### Check the result:

kubectl get deployments -n dev

kubectl get pods -n dev

<img width="1337" height="331" alt="image" src="https://github.com/user-attachments/assets/0f18379f-d335-42e7-9b33-67f30f5bebdb" />

### Verify:

READY — how many replicas are running vs desired

UP-TO-DATE — number of replicas updated to current spec

AVAILABLE — ready to serve traffic


# Task 4: Self-Healing — Delete a Pod and Watch It Come Back

This is the key difference between a Deployment and a standalone Pod.

### List pods
kubectl get pods -n dev

### Delete one of the deployment's pods (use an actual pod name from your output)
kubectl delete pod <pod-name> -n dev

### Immediately check again
kubectl get pods -n dev

<img width="1396" height="382" alt="image" src="https://github.com/user-attachments/assets/ac1f646e-5611-48be-b69a-a413a2ca4d95" />

<img width="1347" height="426" alt="image" src="https://github.com/user-attachments/assets/eb50e061-863a-4ee4-8195-3fee3eeb7f00" />

Key Point:

Pod names include a random suffix

When recreated, Kubernetes generates a new name

The old pod is not restored, a new one is created

### Conclusion:

Deployment ensures the desired state (3 pods), not the exact same pods



# Task 5: Scale the Deployment

Change the number of replicas:

### Scale up to 5
kubectl scale deployment nginx-deployment --replicas=5 -n dev

kubectl get pods -n dev

### Scale down to 2

kubectl scale deployment nginx-deployment --replicas=2 -n dev

kubectl get pods -n dev

<img width="1730" height="407" alt="image" src="https://github.com/user-attachments/assets/7e890227-d020-4e0c-8dea-86c8c029af6a" />

### What exactly happens?

You had 5 running pods

Desired state changed to 2 pods

Kubernetes (via ReplicaSet) removes 3 pods automatically

# Task 6: Rolling Update

## Update the Nginx image version to trigger a rolling update:

kubectl set image deployment/nginx-deployment nginx=nginx:1.25 -n dev

## Watch the rollout in real time:

kubectl rollout status deployment/nginx-deployment -n dev


Kubernetes replaces pods one by one — old pods are terminated only after new ones are healthy. This means zero downtime.

## Check the rollout history:

kubectl rollout history deployment/nginx-deployment -n dev


## Now roll back to the previous version:

kubectl rollout undo deployment/nginx-deployment -n dev

kubectl rollout status deployment/nginx-deployment -n dev


## Verify the image is back to the previous version:

kubectl describe deployment nginx-deployment -n dev | grep Image

<img width="1743" height="597" alt="image" src="https://github.com/user-attachments/assets/f76b6cda-da58-4533-9e70-bd78b88a28eb" />


### Rollback always restores the previous stable version of the Deployment


# Task 7: Clean Up

kubectl delete deployment nginx-deployment -n dev

kubectl delete pod nginx-dev -n dev

kubectl delete pod nginx-staging -n staging

kubectl delete namespace dev staging production

Deleting a namespace removes everything inside it. Be very careful with this in production.

kubectl get namespaces

kubectl get pods -A

<img width="1598" height="680" alt="image" src="https://github.com/user-attachments/assets/a692367a-3f11-4e26-ae8f-c55e5b3c3824" />


## Verify: Are all your resources gone?

all your resources should be gone if all delete commands executed successfully.

When you delete a namespace, Kubernetes automatically deletes:

Pods

Deployments

Services

ReplicaSets

EVERYTHING inside that namespace

This is called cascading deletion.





Namespaces — organize resources, prevent collisions, isolate environments.

Deployment Manifest — explains replicas, selector, template, containers.

Self-healing Pods — difference from standalone pods.

Scaling — how Kubernetes adjusts pod count automatically.

Rolling Updates & Rollbacks — update containers with zero downtime.

Screenshots — include kubectl get deployments -n dev and kubectl get pods -A.



