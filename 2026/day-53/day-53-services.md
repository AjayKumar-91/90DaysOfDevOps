# Why Services?

Pods are ephemeral and get dynamic IPs. A Deployment running multiple Pods creates the following challenges:

Pod IPs change when Pods restart.

Multiple Pods — which Pod IP should you connect to?

Solution: A Kubernetes Service provides:

A stable IP (ClusterIP) and optional DNS name.

Load balancing across all Pods matching the Service selector

[Client] --> [Service (stable IP)] --> [Pod 1]
                                   --> [Pod 2]
                                   --> [Pod 3]


# Task 1: Deploy the Application

First, create a Deployment that you will expose with Services. Create app-deployment.yaml:


<img width="1897" height="262" alt="image" src="https://github.com/user-attachments/assets/e55d050b-bb0e-4a9b-b5eb-7adfc79c2775" />

## Verify:

All 3 Pods are Running.

Note their IP addresses (these are dynamic and will change on restart).


# Task 2: ClusterIP Service (Internal Access)

ClusterIP is the default Service type. It gives your Pods a stable internal IP that is only reachable from within the cluster.

Create clusterip-service.yaml:


<img width="1918" height="867" alt="image" src="https://github.com/user-attachments/assets/6c114448-e702-4f9f-b9a4-d9675c0163a8" />


You should see the Nginx welcome page.

Repeated wget requests will demonstrate load balancing across Pods.


# Task 3: Discover Services with DNS

Kubernetes automatically creates DNS entries for Services:

Short name: web-app-clusterip

Full DNS name: web-app-clusterip.default.svc.cluster.local

Test DNS resolution:

kubectl run dns-test --image=busybox:latest --rm -it --restart=Never -- sh

wget -qO- http://web-app-clusterip

wget -qO- http://web-app-clusterip.default.svc.cluster.local

nslookup web-app-clusterip

exit

<img width="1918" height="917" alt="image" src="https://github.com/user-attachments/assets/419ac149-0321-4b73-81c0-bb8344211a85" />

<img width="1918" height="977" alt="image" src="https://github.com/user-attachments/assets/fe00dd05-f5a2-4759-871f-d37076eb75c3" />

<img width="1005" height="142" alt="image" src="https://github.com/user-attachments/assets/49c44fa1-3c96-44e6-8011-515aa10635e3" />


Verify that nslookup returns the ClusterIP.

Short name works within the same namespace; full DNS name works across namespaces.


# Task 4: NodePort Service (External Access via Node)

Manifest (nodeport-service.yaml)

### Apply:

kubectl apply -f nodeport-service.yaml

kubectl get services

### Access the service:

Minikube: minikube service web-app-nodeport --url

Kind: curl <node-ip>:30080

Docker Desktop: curl http://localhost:30080

<img width="1918" height="947" alt="image" src="https://github.com/user-attachments/assets/2538c158-6b82-43e7-a537-b5066cfcbb29" />

You should see the Nginx welcome page from outside the cluster.
<img width="1917" height="341" alt="image" src="https://github.com/user-attachments/assets/341d0f19-6b4b-484d-80f7-cc3fff46e779" />


# Task 5: LoadBalancer Service (Cloud External Access)

In a cloud environment (AWS, GCP, Azure), a LoadBalancer Service provisions a real external load balancer that routes traffic to your nodes.

### Create loadbalancer-service.yaml:

kubectl apply -f loadbalancer-service.yaml

kubectl get services

### Minikube simulation:

minikube tunnel

kubectl get services

<img width="1918" height="930" alt="image" src="https://github.com/user-attachments/assets/32113dd3-f01f-4158-bbfc-dbeec4b7015b" />


Verify: The LoadBalancer service automatically creates a ClusterIP and a NodePort.


# Task 6: Understand the Service Types Side by Side

| Type         | Accessible From                   | Use Case                                |
| ------------ | --------------------------------- | --------------------------------------- |
| ClusterIP    | Inside cluster only               | Internal communication between services |
| NodePort     | Outside via `<NodeIP>:<NodePort>` | Development, testing                    |
| LoadBalancer | Outside via cloud load balancer   | Production traffic in cloud             |


### Check all three services:

kubectl get services -o wide

kubectl describe service web-app-loadbalancer

Hierarchy: LoadBalancer → NodePort → ClusterIP

<img width="1887" height="652" alt="image" src="https://github.com/user-attachments/assets/f0be69a8-8b59-4274-8cf5-801b35ccd195" />


# Task 7: Clean Up

kubectl delete -f app-deployment.yaml

kubectl delete -f clusterip-service.yaml

kubectl delete -f nodeport-service.yaml

kubectl delete -f loadbalancer-service.yaml

kubectl get pods

kubectl get services

Only the default Kubernetes service should remain.


<img width="1916" height="390" alt="image" src="https://github.com/user-attachments/assets/e953580d-3476-4afb-9944-5e9a25d227f7" />



# Notes

kubectl get endpoints <service-name> shows which Pod IPs a Service routes to.

port is the Service port; targetPort is the Pod container port.

NodePort range: 30000–32767. If unspecified, Kubernetes chooses automatically.

Always match Service selector labels with Pod labels.


