## Challenge Tasks

### Task 1: Create Your First Pod (Nginx)
Create a file called `nginx-pod.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
```

Apply it:
```bash
kubectl apply -f nginx-pod.yaml
```

Verify:
```bash
kubectl get pods
kubectl get pods -o wide
```

Wait until the STATUS shows `Running`. Then explore:
```bash
# Detailed info about the pod
kubectl describe pod nginx-pod

# Read the logs
kubectl logs nginx-pod

# Get a shell inside the container
kubectl exec -it nginx-pod -- /bin/bash

# Inside the container, run:
curl localhost:80
exit
```

**Verify:** Can you see the Nginx welcome page when you curl from inside the pod?

---

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



### Task 2: Create a Custom Pod (BusyBox)
Write a new manifest `busybox-pod.yaml` from scratch (do not copy-paste the nginx one):

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox-pod
  labels:
    app: busybox
    environment: dev
spec:
  containers:
  - name: busybox
    image: busybox:latest
    command: ["sh", "-c", "echo Hello from BusyBox && sleep 3600"]
```

Apply and verify:
```bash
kubectl apply -f busybox-pod.yaml
kubectl get pods
kubectl logs busybox-pod
```

Notice the `command` field — BusyBox does not run a long-lived server like Nginx. Without a command that keeps it running, the container would exit immediately and the pod would go into `CrashLoopBackOff`.

**Verify:** Can you see "Hello from BusyBox" in the logs?

---


<img width="1257" height="196" alt="image" src="https://github.com/user-attachments/assets/c1fe2d91-79a2-4f9e-8bfc-a8762c39e32e" />

### Task 3: Imperative vs Declarative
You have been using the declarative approach (writing YAML, then `kubectl apply`). Kubernetes also supports imperative commands:

```bash
# Create a pod without a YAML file
kubectl run redis-pod --image=redis:latest

# Check it
kubectl get pods
```

Now extract the YAML that Kubernetes generated:
```bash
kubectl get pod redis-pod -o yaml
```

Compare this output with your hand-written manifests. Notice how much extra metadata Kubernetes adds automatically (status, timestamps, uid, resource version).

You can also use dry-run to generate YAML without creating anything:
```bash
kubectl run test-pod --image=nginx --dry-run=client -o yaml
```

This is a powerful trick — use it to quickly scaffold a manifest, then customize it.

**Verify:** Save the dry-run output to a file and compare its structure with your nginx-pod.yaml. What fields are the same? What is different?

---

<img width="1918" height="930" alt="image" src="https://github.com/user-attachments/assets/4ba17c4a-8b3e-4385-8a23-0f2409df81cc" />

Compare this output with your hand-written manifests. Notice how much extra metadata Kubernetes adds automatically (status, timestamps, uid, resource version).

You can also use dry-run to generate YAML without creating anything:

<img width="1720" height="352" alt="image" src="https://github.com/user-attachments/assets/f21a9f9b-6d3d-4d4c-b81a-b87848b68b83" />


### Task 4: Validate Before Applying
Before applying a manifest, you can validate it:

```bash
# Check if the YAML is valid without actually creating the resource
kubectl apply -f nginx-pod.yaml --dry-run=client

# Validate against the cluster's API (server-side validation)
kubectl apply -f nginx-pod.yaml --dry-run=server
```

Now intentionally break your YAML (remove the `image` field or add an invalid field) and run dry-run again. See what error you get.

**Verify:** What error does Kubernetes give when the image field is missing?

---

# Key Learnings

- Learned Kubernetes manifest structure and the purpose of **`apiVersion`**, **`kind`**, **`metadata`**, and **`spec`**.
- Created Pods manually using YAML manifest files.
- Deployed and managed **Nginx** and **BusyBox** containers in Kubernetes.
- Explored Pod debugging using **`kubectl logs`**, **`kubectl describe`**, and **`kubectl exec`**.
- Understood the difference between **Imperative** (`kubectl run`) and **Declarative** (`kubectl apply -f`) approaches.
- Practiced using **Labels** and **Selectors** to organize and filter Kubernetes resources.
- Validated manifests using **client-side** and **server-side dry runs** before deployment.
- Learned that standalone Pods are **not automatically recreated** after deletion.
- Understood why **Deployments** are preferred over standalone Pods in production environments.

<img width="1291" height="95" alt="image" src="https://github.com/user-attachments/assets/db183d7f-61ea-44b0-9d34-21c8434d4433" />


### Task 5: Pod Labels and Filtering
Labels are how Kubernetes organizes and selects resources. You added labels in your manifests — now use them:

```bash
# List all pods with their labels
kubectl get pods --show-labels

# Filter pods by label
kubectl get pods -l app=nginx
kubectl get pods -l environment=dev

# Add a label to an existing pod
kubectl label pod nginx-pod environment=production

# Verify
kubectl get pods --show-labels

# Remove a label
kubectl label pod nginx-pod environment-
```

Write a manifest for a third pod with at least 3 labels (app, environment, team). Apply it and practice filtering.

---


<img width="1545" height="466" alt="image" src="https://github.com/user-attachments/assets/0bef562d-041c-4f86-907c-3ea041b552bb" />


### Task 6: Clean Up
Delete all the pods you created:

```bash
# Delete by name
kubectl delete pod nginx-pod
kubectl delete pod busybox-pod
kubectl delete pod redis-pod

# Or delete using the manifest file
kubectl delete -f nginx-pod.yaml

# Verify everything is gone
kubectl get pods
```

Notice that when you delete a standalone Pod, it is gone forever. There is no controller to recreate it. This is why in production you use Deployments (coming on Day 52) instead of bare Pods.

---

<img width="1728" height="273" alt="image" src="https://github.com/user-attachments/assets/f38fd497-bf83-445c-ba07-21ccfb4cff26" />

spec → container definitions, image, ports, commands

