# Task 1: Explore Default Namespaces
Kubernetes comes with built-in namespaces. List them:

```bash
kubectl get namespaces
```

You should see at least:
- `default` — where your resources go if you do not specify a namespace
- `kube-system` — Kubernetes internal components (API server, scheduler, etc.)
- `kube-public` — publicly readable resources
- `kube-node-lease` — node heartbeat tracking

Check what is running inside `kube-system`:
```bash
kubectl get pods -n kube-system
```

These are the control plane components keeping your cluster alive. Do not touch them.

**Verify:** How many pods are running in `kube-system`?

---


<img width="1263" height="421" alt="image" src="https://github.com/user-attachments/assets/270a7b69-b197-4b4b-9259-5a6306b70bb7" />

### Verify:

Count how many pods are running. These are core control-plane components — do not modify them.


# Task 2: Create and Use Custom Namespaces
Create two namespaces — one for a development environment and one for staging:

```bash
kubectl create namespace dev
kubectl create namespace staging
```

Verify they exist:
```bash
kubectl get namespaces
```

You can also create a namespace from a manifest:
```yaml
# namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```

```bash
kubectl apply -f namespace.yaml
```

Now run a pod in a specific namespace:
```bash
kubectl run nginx-dev --image=nginx:latest -n dev
kubectl run nginx-staging --image=nginx:latest -n staging
```

List pods across all namespaces:
```bash
kubectl get pods -A
```

Notice that `kubectl get pods` without `-n` only shows the `default` namespace. You must specify `-n <namespace>` or use `-A` to see everything.

**Verify:** Does `kubectl get pods` show these pods? What about `kubectl get pods -A`?

---

<img width="1615" height="778" alt="image" src="https://github.com/user-attachments/assets/36fde7d3-723d-477e-9252-b45aba7a6ee8" />

### Verify: Running kubectl get pods without -n shows only the default namespace. -A shows all.

# Task 3: Create Your First Deployment
A Deployment tells Kubernetes: "I want X replicas of this Pod running at all times." If a Pod crashes, the Deployment controller recreates it automatically.

Create a file `nginx-deployment.yaml`:

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

Key differences from a standalone Pod:
- `kind: Deployment` instead of `kind: Pod`
- `apiVersion: apps/v1` instead of `v1`
- `replicas: 3` tells Kubernetes to maintain 3 identical pods
- `selector.matchLabels` connects the Deployment to its Pods
- `template` is the Pod template — the Deployment creates Pods using this blueprint

Apply it:
```bash
kubectl apply -f nginx-deployment.yaml
```

Check the result:
```bash
kubectl get deployments -n dev
kubectl get pods -n dev
```

You should see 3 pods with names like `nginx-deployment-xxxxx-yyyyy`.

**Verify:** What do the READY, UP-TO-DATE, and AVAILABLE columns mean in the deployment output?

---

<img width="1337" height="331" alt="image" src="https://github.com/user-attachments/assets/0f18379f-d335-42e7-9b33-67f30f5bebdb" />

### Verify:

READY — Pods currently ready to serve traffic.

UP-TO-DATE — Pods running the latest Deployment specification.

AVAILABLE — Pods available and healthy for serving requests.


# Task 4: Self-Healing — Delete a Pod and Watch It Come Back
This is the key difference between a Deployment and a standalone Pod.

```bash
# List pods
kubectl get pods -n dev

# Delete one of the deployment's pods (use an actual pod name from your output)
kubectl delete pod <pod-name> -n dev

# Immediately check again
kubectl get pods -n dev
```

The Deployment controller detects that only 2 of 3 desired replicas exist and immediately creates a new one. The deleted pod is replaced within seconds.

**Verify:** Is the replacement pod's name the same as the one you deleted, or different?

---

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

```bash
# Scale up to 5
kubectl scale deployment nginx-deployment --replicas=5 -n dev
kubectl get pods -n dev

# Scale down to 2
kubectl scale deployment nginx-deployment --replicas=2 -n dev
kubectl get pods -n dev
```

Watch how Kubernetes creates or terminates pods to match the desired count.

You can also scale by editing the manifest — change `replicas: 4` in your YAML file and run `kubectl apply -f nginx-deployment.yaml` again.

**Verify:** When you scaled down from 5 to 2, what happened to the extra pods?

---

<img width="1730" height="407" alt="image" src="https://github.com/user-attachments/assets/7e890227-d020-4e0c-8dea-86c8c029af6a" />

### What exactly happens?

You had 5 running pods

Desired state changed to 2 pods

Kubernetes (via ReplicaSet) removes 3 pods automatically

# Task 6: Rolling Update
Update the Nginx image version to trigger a rolling update:

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.25 -n dev
```

Watch the rollout in real time:
```bash
kubectl rollout status deployment/nginx-deployment -n dev
```

Kubernetes replaces pods one by one — old pods are terminated only after new ones are healthy. This means zero downtime.

Check the rollout history:
```bash
kubectl rollout history deployment/nginx-deployment -n dev
```

Now roll back to the previous version:
```bash
kubectl rollout undo deployment/nginx-deployment -n dev
kubectl rollout status deployment/nginx-deployment -n dev
```

Verify the image is back to the previous version:
```bash
kubectl describe deployment nginx-deployment -n dev | grep Image
```

**Verify:** What image version is running after the rollback?

---

## Verify the image is back to the previous version:

kubectl describe deployment nginx-deployment -n dev | grep Image

<img width="1743" height="597" alt="image" src="https://github.com/user-attachments/assets/f76b6cda-da58-4533-9e70-bd78b88a28eb" />


### Rollback always restores the previous stable version of the Deployment

# Task 7: Clean Up
```bash
kubectl delete deployment nginx-deployment -n dev
kubectl delete pod nginx-dev -n dev
kubectl delete pod nginx-staging -n staging
kubectl delete namespace dev staging production
```

Deleting a namespace removes everything inside it. Be very careful with this in production.

```bash
kubectl get namespaces
kubectl get pods -A
```

**Verify:** Are all your resources gone?

---

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

Namespaces provide logical separation of resources within a Kubernetes cluster, while Deployments provide production-grade application management through self-healing, scaling, rolling updates, and rollback capabilities. Deployments are the recommended way to run applications in Kubernetes because they ensure the desired application state is always maintained.
