# Day 52 – Kubernetes Namespaces and Deployments

## Objective
Learn how Kubernetes Namespaces help organize cluster resources and how Deployments provide self-healing, scaling, and rolling updates for applications.

---

# What are Namespaces?

Namespaces are virtual partitions inside a Kubernetes cluster that help organize and isolate resources.

## Why Use Namespaces?

- Separate environments (Development, Staging, Production)
- Resource isolation
- Access control using RBAC
- Easier management of large clusters
- Avoid naming conflicts

## Built-in Namespaces

| Namespace | Purpose |
|------------|---------|
| default | Default namespace for resources |
| kube-system | Kubernetes system components |
| kube-public | Publicly readable resources |
| kube-node-lease | Node heartbeat tracking |

### List Namespaces

```bash
kubectl get namespaces
```

### View System Pods

```bash
kubectl get pods -n kube-system
```

These pods run critical Kubernetes components such as:

- API Server
- Scheduler
- Controller Manager
- CoreDNS
- etcd

---

# Creating Custom Namespaces

## Imperative Method

```bash
kubectl create namespace dev
kubectl create namespace staging
```

Verify:

```bash
kubectl get namespaces
```

---

## Declarative Method

### namespace.yaml

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```

Apply:

```bash
kubectl apply -f namespace.yaml
```

---

# Running Pods in Different Namespaces

```bash
kubectl run nginx-dev --image=nginx:latest -n dev

kubectl run nginx-staging --image=nginx:latest -n staging
```

List all pods:

```bash
kubectl get pods -A
```

### Observation

```bash
kubectl get pods
```

Shows only resources in the default namespace.

```bash
kubectl get pods -A
```

Shows resources from all namespaces.

---

# Deployment Manifest

## nginx-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx-deployment
  namespace: dev
  labels:
    app: nginx

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
      - name: nginx
        image: nginx:1.24

        ports:
        - containerPort: 80
```

---

# Deployment Manifest Explanation

## apiVersion

```yaml
apiVersion: apps/v1
```

Defines which Kubernetes API version manages the resource.

---

## kind

```yaml
kind: Deployment
```

Specifies that the resource is a Deployment.

---

## metadata

```yaml
metadata:
  name: nginx-deployment
  namespace: dev
```

Contains identification information.

- Name of deployment
- Namespace where it runs

---

## replicas

```yaml
replicas: 3
```

Kubernetes maintains three identical Pods at all times.

---

## selector

```yaml
selector:
  matchLabels:
    app: nginx
```

Deployment uses this label selector to identify which Pods belong to it.

---

## template

```yaml
template:
```

Pod blueprint used by the Deployment.

Every Pod created by the Deployment follows this template.

---

## containers

```yaml
containers:
- name: nginx
  image: nginx:1.24
```

Defines the container image and runtime configuration.

---

# Creating the Deployment

Apply the manifest:

```bash
kubectl apply -f nginx-deployment.yaml
```

Verify:

```bash
kubectl get deployments -n dev

kubectl get pods -n dev
```

Example:

```text
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           1m
```

---

# Deployment Status Columns

## READY

```text
3/3
```

Pods currently ready to serve traffic.

## UP-TO-DATE

```text
3
```

Pods running the latest Deployment specification.

## AVAILABLE

```text
3
```

Pods available and healthy for serving requests.

---

# Self-Healing Feature

List Pods:

```bash
kubectl get pods -n dev
```

Delete one Pod:

```bash
kubectl delete pod <pod-name> -n dev
```

Check again:

```bash
kubectl get pods -n dev
```

### Observation

The deleted Pod is automatically recreated by the Deployment controller.

Example:

Deleted Pod:

```text
nginx-deployment-7f8b9c7d8f-abcd1
```

New Pod:

```text
nginx-deployment-7f8b9c7d8f-xyz12
```

The replacement Pod has a different name because it is newly created.

---

# Deployment vs Standalone Pod

## Standalone Pod

```bash
kubectl run nginx --image=nginx
```

If deleted:

```bash
kubectl delete pod nginx
```

Result:

```text
Pod permanently removed.
```

No automatic recovery.

---

## Deployment Managed Pod

If deleted:

```bash
kubectl delete pod <pod-name>
```

Result:

```text
Deployment creates a replacement Pod automatically.
```

Self-healing is enabled.

---

# Scaling Deployments

## Imperative Scaling

Scale Up:

```bash
kubectl scale deployment nginx-deployment --replicas=5 -n dev
```

Verify:

```bash
kubectl get pods -n dev
```

Now 5 Pods are running.

Scale Down:

```bash
kubectl scale deployment nginx-deployment --replicas=2 -n dev
```

Verify:

```bash
kubectl get pods -n dev
```

Only 2 Pods remain.

### Observation

When scaling down, Kubernetes terminates extra Pods gracefully until the desired replica count is reached.

---

## Declarative Scaling

Modify the YAML file:

```yaml
replicas: 4
```

Apply:

```bash
kubectl apply -f nginx-deployment.yaml
```

Kubernetes updates the Deployment to 4 replicas.

---

# Rolling Updates

Update image version:

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.25 -n dev
```

Monitor rollout:

```bash
kubectl rollout status deployment/nginx-deployment -n dev
```

View rollout history:

```bash
kubectl rollout history deployment/nginx-deployment -n dev
```

### What Happens?

1. New Pods are created with nginx:1.25
2. Health checks are performed
3. Old Pods are terminated gradually
4. Application remains available

This process provides zero or near-zero downtime.

---

# Rollback

Undo deployment update:

```bash
kubectl rollout undo deployment/nginx-deployment -n dev
```

Check rollout status:

```bash
kubectl rollout status deployment/nginx-deployment -n dev
```

Verify image:

```bash
kubectl describe deployment nginx-deployment -n dev | grep Image
```

Expected Output:

```text
Image: nginx:1.24
```

### Observation

Deployment returns to the previous stable revision.

---

# ReplicaSets

Deployments manage ReplicaSets internally.

View them:

```bash
kubectl get replicasets -n dev
```

Example:

```text
NAME                          DESIRED   CURRENT   READY
nginx-deployment-6f45ddf5c8   0         0         0
nginx-deployment-7f8b9c7d8f   3         3         3
```

ReplicaSets ensure the desired number of Pods exists.

---

# Verification Answers

## What do READY, UP-TO-DATE, and AVAILABLE mean?

- READY: Number of Pods ready to serve traffic.
- UP-TO-DATE: Pods running the latest deployment specification.
- AVAILABLE: Healthy Pods available for requests.

## Is the replacement Pod name the same after deletion?

No. Kubernetes creates a new Pod with a different unique name.

## What happens when scaling down from 5 to 2 replicas?

Kubernetes gracefully terminates the extra 3 Pods and keeps only 2 running.

## Which image version runs after rollback?

The Deployment returns to the previous version:

```text
nginx:1.24
```

## Are all resources gone after cleanup?

Yes. After deleting the Deployment and namespaces, all associated Pods and resources are removed.

---

# Cleanup

Delete Deployment:

```bash
kubectl delete deployment nginx-deployment -n dev
```

Delete Pods:

```bash
kubectl delete pod nginx-dev -n dev

kubectl delete pod nginx-staging -n staging
```

Delete Namespaces:

```bash
kubectl delete namespace dev staging production
```

Verify:

```bash
kubectl get namespaces

kubectl get pods -A
```

---

# Screenshots

## Deployment Status

```bash
kubectl get deployments -n dev
```

> Insert screenshot here

---

## Pods Across All Namespaces

```bash
kubectl get pods -A
```

> Insert screenshot here

---

# Key Learnings

- Learned Kubernetes Namespace concepts and resource isolation.
- Explored built-in namespaces.
- Created custom namespaces using imperative and declarative methods.
- Ran Pods inside different namespaces.
- Created a Deployment with multiple replicas.
- Understood Deployment manifest structure.
- Learned self-healing behavior of Deployments.
- Scaled Deployments using imperative and declarative methods.
- Performed rolling updates with zero downtime.
- Rolled back Deployment revisions.
- Explored ReplicaSets created by Deployments.
- Learned cleanup of namespaces and resources.

---

# Conclusion

Namespaces provide logical separation of resources within a Kubernetes cluster, 
while Deployments provide production-grade application management through self-healing, scaling, 
rolling updates, and rollback capabilities. 

Deployments are the recommended way to run applications in Kubernetes because they ensure the desired application state is always maintained.
