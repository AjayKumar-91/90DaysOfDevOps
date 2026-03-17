# Task 1: Recall the Kubernetes Story

Write from memory first:

Why Kubernetes was created: Docker solves containerization, but managing hundreds of containers across multiple servers is hard. Kubernetes automates deployment, scaling, and management of containerized applications.

Who created it and inspiration: Google created Kubernetes, inspired by their internal system called Borg.

Meaning of the name "Kubernetes": Greek for “helmsman” or “pilot,” symbolizing steering and managing containers.

Verification: Check official docs; these are correct.

# Task 2: Kubernetes Architecture

Text-based architecture diagram:

Control Plane (Master Node):
  ├─ API Server          # Front door, handles kubectl requests
  ├─ etcd                # Key-value store for cluster state
  ├─ Scheduler           # Assigns pods to worker nodes
  └─ Controller Manager  # Ensures desired state matches reality

Worker Node:
  ├─ kubelet             # Agent managing pods, talks to API server
  ├─ kube-proxy          # Manages networking rules for pod communication
  └─ Container Runtime   # Runs containers (containerd, CRI-O)

Request flow (kubectl apply -f pod.yaml):

kubectl sends request → API Server

API Server validates → stores state in etcd

Scheduler picks a node for the pod

Controller Manager ensures pod gets created

kubelet on the worker node starts container via container runtime

kube-proxy configures networking

Failure scenarios:

API Server down → kubectl cannot communicate; cluster still running but management stops.

Worker node down → pods on that node fail; Scheduler may reschedule depending on deployment.


# Task 3: Install kubectl

## Linux commands:

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

kubectl version --client


# Task 4: Set Up Local Cluster

Option chosen: kind (Kubernetes in Docker)

Reason: Lightweight, runs entirely in Docker, easy to recreate clusters quickly.

## Commands to create cluster:

### Install kind (Linux)
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64

chmod +x ./kind

sudo mv ./kind /usr/local/bin/kind

### Create cluster
kind create cluster --name devops-cluster

### Verify

kubectl cluster-info

kubectl get nodes

# Task 5: Explore Cluster

kubectl cluster-info

kubectl get nodes

kubectl describe node <node-name>

kubectl get namespaces

kubectl get pods -A

kubectl get pods -n kube-system

| Pod Name                | Component          |
| ----------------------- | ------------------ |
| kube-apiserver          | API Server         |
| etcd                    | etcd DB            |
| kube-scheduler          | Scheduler          |
| kube-controller-manager | Controller Manager |
| coredns                 | Cluster DNS        |
| kube-proxy              | kube-proxy         |

# Task 6: Practice Cluster Lifecycle

### Delete cluster

kind delete cluster --name devops-cluster

### Recreate cluster

kind create cluster --name devops-cluster

### Verify

kubectl get nodes

### Useful config commands

kubectl config current-context

kubectl config get-contexts

kubectl config view


# Notes:

kubeconfig: Stores cluster connection info, user credentials, contexts. Default location: ~/.kube/config.

## Kubernetes History
Kubernetes was created by Google to manage containerized applications at scale. Inspired by their internal system Borg, it automates deployment, scaling, and operations of containers. The name "Kubernetes" means "helmsman" in Greek, reflecting its role in steering container workloads.

## Kubernetes Architecture

### Control Plane (Master Node)
- **API Server** – Front door to the cluster, handles all requests from kubectl.
- **etcd** – Key-value store for cluster state.
- **Scheduler** – Decides which node new pods should run on.
- **Controller Manager** – Ensures the desired state matches the actual state.

### Worker Node
- **kubelet** – Agent on each node that manages pods and communicates with API Server.
- **kube-proxy** – Handles networking rules so pods can communicate.
- **Container Runtime** – Runs containers (containerd, CRI-O).

**Request flow example:** When running `kubectl apply -f pod.yaml`:
1. kubectl sends request → API Server  
2. API Server validates request → stores state in etcd  
3. Scheduler assigns pod to a node  
4. Controller Manager ensures pod is created  
5. kubelet starts container using Container Runtime  
6. kube-proxy configures networking for the pod  

**Failure scenarios:**
- API Server down → kubectl cannot communicate; cluster still runs but management is unavailable.  
- Worker node down → pods on that node fail; Scheduler may reschedule if using deployments.

---

## Tool Chosen
- **Tool:** kind (Kubernetes in Docker)  
- **Reason:** Lightweight, runs entirely in Docker, easy to recreate clusters quickly.

---

## Cluster Verification

### Nodes
![kubectl get nodes screenshot](kubectl-nodes.png)

### Kube-system Pods
![kubectl get pods -n kube-system screenshot](kube-system-pods.png)
  
