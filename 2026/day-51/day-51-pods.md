# Kubernetes Manifest Basics



Every manifest has four required top-level fields:

apiVersion: v1       # API version to use
kind: Pod            # Resource type
metadata:            # Identity of the resource
  name: my-pod
  labels:
    app: my-app
spec:                # Desired state (containers, images, ports)
  containers:
    - name: my-container
      image: nginx:latest
      ports:
        - containerPort: 80

apiVersion → v1 for Pods

kind → Pod, Deployment, Service, etc.

metadata → name (required), labels (optional but useful for filtering)

# Task 1: Create Your First Pod (Nginx)

Apply it:
kubectl apply -f nginx-pod.yaml

Verify:

kubectl get pods

kubectl get pods -o wide

Wait until the STATUS shows Running. Then explore:

# Detailed info about the pod

kubectl describe pod nginx-pod

<img width="1870" height="855" alt="image" src="https://github.com/user-attachments/assets/ee66394e-a227-468f-9da2-ae2ebe3b5735" />


# Read the logs

kubectl logs nginx-pod

<img width="1347" height="647" alt="image" src="https://github.com/user-attachments/assets/2acfc240-13df-4929-bb13-ec18d651982f" />


# Get a shell inside the container

kubectl exec -it nginx-pod -- /bin/bash

# Inside the container, run:

curl localhost:80

exit


<img width="1301" height="711" alt="image" src="https://github.com/user-attachments/assets/15342567-899d-4c5b-927d-df673268234f" />



# Task 2: Create a Custom Pod (BusyBox)

Apply and verify:

kubectl apply -f busybox-pod.yaml

kubectl get pods

kubectl logs busybox-pod


<img width="1257" height="196" alt="image" src="https://github.com/user-attachments/assets/c1fe2d91-79a2-4f9e-8bfc-a8762c39e32e" />

# Task 3: Imperative vs Declarative

## You have been using the declarative approach (writing YAML, then kubectl apply). Kubernetes also supports imperative commands:

### Create a pod without a YAML file

kubectl run redis-pod --image=redis:latest

### Check it

kubectl get pods

### Now extract the YAML that Kubernetes generated:

kubectl get pod redis-pod -o yaml

<img width="1918" height="930" alt="image" src="https://github.com/user-attachments/assets/4ba17c4a-8b3e-4385-8a23-0f2409df81cc" />

Compare this output with your hand-written manifests. Notice how much extra metadata Kubernetes adds automatically (status, timestamps, uid, resource version).

You can also use dry-run to generate YAML without creating anything:

<img width="1720" height="352" alt="image" src="https://github.com/user-attachments/assets/f21a9f9b-6d3d-4d4c-b81a-b87848b68b83" />



# Task 4: Validate Before Applying

Before applying a manifest, you can validate it:

<img width="1291" height="95" alt="image" src="https://github.com/user-attachments/assets/db183d7f-61ea-44b0-9d34-21c8434d4433" />


# Task 5: Pod Labels and Filtering

Labels are how Kubernetes organizes and selects resources. You added labels in your manifests — now use them:


<img width="1545" height="466" alt="image" src="https://github.com/user-attachments/assets/0bef562d-041c-4f86-907c-3ea041b552bb" />



# Task 6: Clean Up

Delete all the pods you created:

<img width="1728" height="273" alt="image" src="https://github.com/user-attachments/assets/f38fd497-bf83-445c-ba07-21ccfb4cff26" />

spec → container definitions, image, ports, commands

