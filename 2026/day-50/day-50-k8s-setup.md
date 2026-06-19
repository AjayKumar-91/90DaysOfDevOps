# Day 50 – Kubernetes Architecture and Cluster Setup

## Challenge Tasks

### Task 1: Recall the Kubernetes Story
Before touching a terminal, write down from memory:

---
1. Why was Kubernetes created? What problem does it solve that Docker alone cannot?
   
   Kubernetes solves scaling and restarting containers automatically, while earlier engineers had to do it manually.
   
   so basically kubernetes was created to solve container orchestration problems such as
   
            - scalling
            - restarting
            - Managing containers across multiple machines

   Docker helps to create and run containers, but when run many containers across many servers, Docker alone cannot easily manage them.
---         
 
2. Who created Kubernetes and what was it inspired by?
     + **Kubernetes was created by Google in 2014.**
     + **It was inspired Borg tool which was automatically scalling and restarting the cantainer**
     + **later Google donates it to open-source**
     + **Today it is maintained by the Cloud Native Computing Foundation, which is part of the Linux Foundation.**
     + **And they named it as KUBERNETES**
       
---

3. What does the name "Kubernetes" mean?
     + **Kubernetes comes from the Greek word meaning**
     + **Helmsman” or “Ship Pilot” (someone who steers a ship).**
     + **which means the cantainers are the ships and the steerign it is kubernetes**
     + **K8s is the short form of Kubernetes**
     + **There are 8 letters between K and S**
---

### Task 2: Draw the Kubernetes Architecture
From memory, draw or describe the Kubernetes architecture. Your diagram should include:

**Control Plane (Master Node):**
- API Server — the front door to the cluster, every command goes through it
- etcd — the database that stores all cluster state
- Scheduler — decides which node a new pod should run on
- Controller Manager — watches the cluster and makes sure the desired state matches reality

**Worker Node:**
- kubelet — the agent on each node that talks to the API server and manages pods
- kube-proxy — handles networking rules so pods can communicate
- Container Runtime — the engine that actually runs containers (containerd, CRI-O)

After drawing, verify your understanding:
- What happens when you run `kubectl apply -f pod.yaml`? Trace the request through each component.
## 3. What Happens During `kubectl apply -f pod.yaml`?

When a user executes:

```bash
kubectl apply -f pod.yaml
```

the following sequence of events takes place inside the Kubernetes cluster:

### Step 1: kubectl Sends the Request

`kubectl` reads the `pod.yaml` manifest and sends an API request to the Kubernetes API Server.

### Step 2: API Server Validates the Request

The API Server validates the YAML file and checks whether the resource definition is correct.

### Step 3: Desired State is Stored in etcd

After validation, the API Server stores the desired state of the Pod in **etcd**, Kubernetes' distributed key-value database.

### Step 4: Scheduler Selects a Node

The **kube-scheduler** detects that a new Pod needs to be created and chooses the most suitable worker node based on available resources and scheduling policies.

### Step 5: kubelet Receives Instructions

The **kubelet** running on the selected worker node notices the new Pod assignment and communicates with the container runtime.

### Step 6: Container Runtime Starts the Container

The container runtime (such as **containerd** or **CRI-O**) pulls the required container image (if not already present) and starts the container.

### Step 7: Networking is Configured

**kube-proxy** configures the necessary networking rules so the Pod can communicate with other Pods and Services within the cluster.

### Step 8: Pod Becomes Running

Once the container is successfully started and passes any health checks, the Pod status changes to **Running**.

### Request Flow Diagram

```text
kubectl
   |
   v
API Server
   |
   v
etcd (stores desired state)
   |
   v
Scheduler
   |
   v
Worker Node
   |
   +--> kubelet
            |
            v
   Container Runtime
            |
            v
          Pod
            |
            v
      kube-proxy
```

## What Happens if the API Server Goes Down?

The Kubernetes API Server is the central communication hub of the cluster. All cluster operations pass through it.

### Impact:

* `kubectl` commands stop working because they cannot communicate with the cluster.
* New Pods, Deployments, Services, or other resources cannot be created or modified.
* Controllers and schedulers cannot update cluster state.
* Existing running Pods continue to run because they are already managed by the kubelet on worker nodes.
* Cluster state stored in etcd remains intact.

### Summary:

The cluster continues running existing workloads, but no management or orchestration operations can occur until the API Server is restored.

---

## What Happens if a Worker Node Goes Down?

A worker node is responsible for running application Pods. If it becomes unavailable, Kubernetes detects the failure.

### Impact:

* The node status changes from **Ready** to **NotReady**.
* Pods running on that node become unavailable.
* The Controller Manager detects the node failure.
* If the Pods are managed by a Deployment, ReplicaSet, or StatefulSet, Kubernetes automatically creates replacement Pods on healthy worker nodes.
* Users may experience temporary service disruption until replacement Pods become available.

### Example:

If a Deployment is configured with **3 replicas** and one worker node fails, Kubernetes schedules replacement Pods on remaining healthy nodes to maintain the desired state.

### Summary:

Kubernetes provides self-healing capabilities. When a worker node fails, workloads are automatically rescheduled to healthy nodes whenever possible.


---

### Task 3: Install kubectl
`kubectl` is the CLI tool you will use to talk to your Kubernetes cluster.

Install it:
```bash
# macOS
brew install kubectl

# Linux (amd64)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Windows (with chocolatey)
choco install kubernetes-cli
```

Verify:
```bash
kubectl version --client
```
<img width="1222" height="172" alt="image" src="https://github.com/user-attachments/assets/72a1cef9-7c6b-41f5-aa6d-58eef447ff19" />

---

### Task 4: Set Up Your Local Cluster
Choose **one** of the following. Both give you a fully functional Kubernetes cluster on your machine.

**Option A: kind (Kubernetes in Docker)**
```bash
# Install kind
# macOS
brew install kind

# Linux
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Create a cluster
kind create cluster --name devops-cluster

# Verify
kubectl cluster-info
kubectl get nodes
```

**Option B: minikube**
```bash
# Install minikube
# macOS
brew install minikube

# Linux
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start a cluster
minikube start

# Verify
kubectl cluster-info
kubectl get nodes
```
<img width="1266" height="207" alt="image" src="https://github.com/user-attachments/assets/2e7de682-ef0c-47de-9603-b5671ccc3f56" />

Write down: Which one did you choose and why?

---

### Task 5: Explore Your Cluster
Now that your cluster is running, explore it:

```bash
# See cluster info
kubectl cluster-info

# List all nodes
kubectl get nodes

# Get detailed info about your node
kubectl describe node <node-name>

# List all namespaces
kubectl get namespaces

# See ALL pods running in the cluster (across all namespaces)
kubectl get pods -A
```
<img width="1516" height="732" alt="image" src="https://github.com/user-attachments/assets/1cbed377-105c-4e5a-9109-ac4de6b053b2" />


<img width="787" height="156" alt="image" src="https://github.com/user-attachments/assets/7da5569a-dd92-44ba-9e05-d7c1e1c83163" />

<img width="1127" height="247" alt="image" src="https://github.com/user-attachments/assets/d7ad8c7f-acaa-4170-96aa-d9ab4aaf2401" />


Look at the pods running in the `kube-system` namespace:
```bash
kubectl get pods -n kube-system
```

<img width="1071" height="246" alt="image" src="https://github.com/user-attachments/assets/8dcd3f86-14cf-4acd-bc01-7750a7e21884" />

You should see pods like `etcd`, `kube-apiserver`, `kube-scheduler`, `kube-controller-manager`, `coredns`, and `kube-proxy`. These are the architecture components you drew in Task 2 — running as pods inside the cluster.

**Verify:** Can you match each running pod in `kube-system` to a component in your architecture diagram?

---

### Task 6: Practice Cluster Lifecycle
Build muscle memory with cluster operations:

```bash
# Delete your cluster
kind delete cluster --name devops-cluster
# (or: minikube delete)

# Recreate it
kind create cluster --name devops-cluster
# (or: minikube start)

# Verify it is back
kubectl get nodes
```

Try these useful commands:
```bash
# Check which cluster kubectl is connected to
kubectl config current-context

# List all available contexts (clusters)
kubectl config get-contexts

# See the full kubeconfig
kubectl config view
```

Write down: What is a kubeconfig? Where is it stored on your machine?

A kubeconfig file contains cluster information, user credentials, and context definitions used by kubectl to connect to Kubernetes clusters.

```bash
~/.kube/config
```
---

Key Learnings

Kubernetes orchestrates containers across multiple machines.

Control Plane manages the cluster state.

Worker Nodes run application workloads.

kubectl communicates with the API Server.

etcd stores cluster configuration and state.
Scheduler decides pod placement.
kubelet manages pod execution.
kube-proxy handles networking.
kind provides a lightweight local Kubernetes environment.
