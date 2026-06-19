# Day 53 – Kubernetes Services

## Objective

Learn how Kubernetes Services provide stable networking and load balancing for Pods managed by Deployments.

---

# Why Kubernetes Services?

Pods are ephemeral. Whenever a Pod is deleted, restarted, or recreated by a Deployment, it receives a new IP address.

This creates two major challenges:

1. Pod IP addresses are not permanent.
2. Deployments run multiple Pods, making it difficult to know which Pod to connect to.

A Kubernetes Service solves these problems by providing:

* A stable virtual IP address
* A DNS name
* Automatic load balancing across matching Pods

### Architecture

```text
Client
   |
   v
Service (Stable IP)
   |
   +----> Pod 1
   +----> Pod 2
   +----> Pod 3
```

The Service remains constant even when Pods are replaced.

---

# Task 1 – Deployment Creation

## app-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  labels:
    app: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
```

### Apply Deployment

```bash
kubectl apply -f app-deployment.yaml
kubectl get pods -o wide
```

### Sample Output

```bash
NAME                       READY   STATUS    IP
web-app-5f76f7f6f4-abc12   1/1     Running   10.244.0.12
web-app-5f76f7f6f4-def34   1/1     Running   10.244.0.13
web-app-5f76f7f6f4-ghi56   1/1     Running   10.244.0.14
```

Observation:

* Each Pod has its own IP.
* These IPs may change after restart.

---

# Task 2 – ClusterIP Service

ClusterIP is the default Service type.

It exposes an application only inside the cluster.

## clusterip-service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-clusterip
spec:
  type: ClusterIP
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
```

### Create Service

```bash
kubectl apply -f clusterip-service.yaml
kubectl get services
```

### Sample Output

```bash
NAME                TYPE        CLUSTER-IP
web-app-clusterip   ClusterIP   10.96.120.45
```

---

## Testing ClusterIP

```bash
kubectl run test-client \
--image=busybox \
--rm -it \
--restart=Never -- sh
```

Inside Pod:

```bash
wget -qO- http://web-app-clusterip
```

### Result

```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
...
</html>
```

Verification:

* Service successfully routed traffic.
* Requests are load-balanced across all Pods.

---

# Task 3 – Service Discovery Using DNS

Kubernetes automatically creates DNS entries for Services.

Format:

```text
<service-name>.<namespace>.svc.cluster.local
```

Example:

```text
web-app-clusterip.default.svc.cluster.local
```

### DNS Test

```bash
kubectl run dns-test \
--image=busybox \
--rm -it \
--restart=Never -- sh
```

Inside Pod:

```bash
wget -qO- http://web-app-clusterip

wget -qO- \
http://web-app-clusterip.default.svc.cluster.local

nslookup web-app-clusterip
```

### Sample Output

```bash
Name: web-app-clusterip
Address: 10.96.120.45
```

Verification:

The DNS entry resolves to the same ClusterIP shown by:

```bash
kubectl get services
```

---

# Task 4 – NodePort Service

NodePort exposes the application outside the cluster through a port on every node.

## nodeport-service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-nodeport
spec:
  type: NodePort
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
```

### Create Service

```bash
kubectl apply -f nodeport-service.yaml
kubectl get services
```

### Sample Output

```bash
NAME               TYPE       PORT(S)
web-app-nodeport   NodePort   80:30080/TCP
```

### Access Service

Docker Desktop:

```bash
curl http://localhost:30080
```

Minikube:

```bash
minikube service web-app-nodeport --url
```

### Result

Nginx welcome page displayed successfully.

---

# Task 5 – LoadBalancer Service

LoadBalancer exposes applications externally through a cloud provider load balancer.

## loadbalancer-service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-loadbalancer
spec:
  type: LoadBalancer
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
```

### Create Service

```bash
kubectl apply -f loadbalancer-service.yaml
kubectl get services
```

### Sample Output

```bash
NAME                    TYPE           EXTERNAL-IP
web-app-loadbalancer    LoadBalancer   <pending>
```

### Why EXTERNAL-IP Shows Pending?

Local environments such as:

* Minikube
* Kind
* Docker Desktop

do not have a cloud provider to provision a real external load balancer.

Therefore:

```text
EXTERNAL-IP = <pending>
```

is expected.

In Minikube:

```bash
minikube tunnel
```

can simulate a LoadBalancer.

---

# Task 6 – Comparing Service Types

| Service Type | Access Scope         | Use Case                            |
| ------------ | -------------------- | ----------------------------------- |
| ClusterIP    | Inside cluster only  | Internal microservice communication |
| NodePort     | NodeIP:NodePort      | Development and testing             |
| LoadBalancer | Public IP / Cloud LB | Production traffic                  |

---

## Relationship Between Service Types

```text
LoadBalancer
      |
      v
NodePort
      |
      v
ClusterIP
```

A LoadBalancer automatically creates:

* ClusterIP
* NodePort

Verification:

```bash
kubectl describe service web-app-loadbalancer
```

Example:

```bash
Type: LoadBalancer

IP: 10.96.85.25

NodePort: 32145/TCP

External-IP: <pending>
```

Observation:

LoadBalancer includes both a ClusterIP and a NodePort.

---

# Understanding Endpoints

Services route traffic using Endpoints.

Endpoints are the actual Pod IPs behind a Service.

View them using:

```bash
kubectl get endpoints web-app-clusterip
```

Example:

```bash
NAME                ENDPOINTS
web-app-clusterip   10.244.0.12:80,
                    10.244.0.13:80,
                    10.244.0.14:80
```

This confirms that the Service is forwarding requests to all Pods.

---

# Service Troubleshooting Commands

```bash
kubectl get services

kubectl get services -o wide

kubectl describe service web-app-clusterip

kubectl get endpoints web-app-clusterip

kubectl get pods --show-labels

kubectl logs <pod-name>
```

---

# Screenshot Section

## kubectl get services

Insert Screenshot Here

```text
[screenshot-services.png]
```

---

## ClusterIP Test Output

Insert Screenshot Here

```text
[screenshot-clusterip-test.png]
```

---

## DNS Resolution Test

Insert Screenshot Here

```text
[screenshot-dns-test.png]
```

---

# Cleanup

```bash
kubectl delete -f app-deployment.yaml

kubectl delete -f clusterip-service.yaml

kubectl delete -f nodeport-service.yaml

kubectl delete -f loadbalancer-service.yaml
```

Verification:

```bash
kubectl get pods

kubectl get services
```

Expected:

```bash
NAME         TYPE        CLUSTER-IP
kubernetes   ClusterIP   10.96.0.1
```

Only the default Kubernetes Service remains.

---

# Key Learnings

* Services provide stable networking for Pods.
* Deployments create and manage Pods.
* ClusterIP enables internal communication.
* NodePort enables external access through nodes.
* LoadBalancer exposes applications in cloud environments.
* Kubernetes DNS automatically creates Service records.
* Endpoints map Services to Pod IP addresses.
* LoadBalancer Services include both NodePort and ClusterIP functionality.
* Service selectors must match Pod labels for traffic routing.
* Services perform load balancing across healthy Pods.
