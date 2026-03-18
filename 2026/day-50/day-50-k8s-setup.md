# Day 1 – Kubernetes Basics (Task 1)

## Recall the Kubernetes Story

### 1. Why was Kubernetes created? What problem does it solve that Docker alone cannot?

Kubernetes was created to manage containerized applications at scale.

While Docker allows us to create and run containers, it does not handle:
- Running containers across multiple machines
- Automatic healing (restarting failed containers)
- Load balancing between containers
- Auto-scaling based on traffic
- Rolling updates and zero-downtime deployments

Kubernetes solves this by providing **container orchestration**, which automates deployment, scaling, networking, and management of containers across a cluster.

---

### 2. Who created Kubernetes and what was it inspired by?

Kubernetes was created by Google.

It was inspired by Google’s internal system called **Borg**, which was used to manage large-scale production workloads for many years.

---

### 3. What does the name "Kubernetes" mean?

The word "Kubernetes" comes from Greek and means:

**"Helmsman" or "Ship Pilot"**

It represents someone who steers a ship, which aligns with Kubernetes’ role in managing and directing containerized applications.

---

## Summary

- **Problem:** Docker cannot manage containers at scale  
- **Solution:** Kubernetes provides container orchestration  
- **Created by:** Google  
- **Inspired by:** Borg  
- **Meaning:** Helmsman (Ship Pilot)

---


# Task 2: Kubernetes Architecture

<img width="1706" height="909" alt="image" src="https://github.com/user-attachments/assets/74cccadf-161b-4aac-a992-db9af8844f91" />


Text-based architecture diagram:

Control Plane (Master Node):

  API Server          -> Front door, handles kubectl requests
  
  etcd                -> Key-value store for cluster state
  
  Scheduler           -> Assigns pods to worker nodes
  
  Controller Manager  -> Ensures desired state matches reality

Worker Node:
  kubelet             -> Agent managing pods, talks to API server
  
  kube-proxy          -> Manages networking rules for pod communication
  
  Container Runtime   -> Runs containers (containerd, CRI-O)

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

<img width="1058" height="135" alt="image" src="https://github.com/user-attachments/assets/d305cb02-2e07-428c-ac48-945a97637b31" />


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


<img width="1376" height="222" alt="image" src="https://github.com/user-attachments/assets/9261bf2f-dc21-4378-9a4a-fafd7a51d3af" />


# Task 5: Explore Cluster

### See cluster info
kubectl cluster-info

###  List all nodes
kubectl get nodes

###  Get detailed info about your node
kubectl describe node <node-name>

###  List all namespaces
kubectl get namespaces

###  See ALL pods running in the cluster (across all namespaces)
kubectl get pods -A

<img width="1572" height="915" alt="image" src="https://github.com/user-attachments/assets/ffa7d551-f057-4541-842b-a94d7d5b5d50" />


### Look at the pods running in the kube-system namespace:
kubectl get pods -n kube-system

<img width="1886" height="257" alt="image" src="https://github.com/user-attachments/assets/8e198c1f-e65a-436a-8ab3-b776d1646fe3" />


| Pod Name                | Architecture Component     | Purpose                          |
| ----------------------- | -------------------------- | -------------------------------- |
| kube-apiserver          | API Server                 | Handles all cluster API requests |
| etcd                    | etcd DB                    | Stores cluster state             |
| kube-scheduler          | Scheduler                  | Assigns pods to nodes            |
| kube-controller-manager | Controller Manager         | Maintains desired state          |
| kube-proxy              | kube-proxy                 | Handles networking between pods  |
| coredns                 | DNS (supporting component) | Service discovery inside cluster |


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

<img width="1918" height="967" alt="image" src="https://github.com/user-attachments/assets/fda72ffd-2f14-459f-937f-2d1ed061f68b" />


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

  
