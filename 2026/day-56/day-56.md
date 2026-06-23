# Day 56 – Kubernetes StatefulSets

## Objective

Learn how StatefulSets provide stable identity, ordered deployment, and persistent storage for stateful applications such as MySQL, PostgreSQL, MongoDB, Kafka, and Elasticsearch.

---

# What are StatefulSets?

A StatefulSet is a Kubernetes workload resource used to manage stateful applications.

Unlike Deployments, StatefulSets provide:

* Stable Pod names
* Stable network identities
* Persistent storage per Pod
* Ordered Pod creation and termination

StatefulSets are commonly used for:

* MySQL
* PostgreSQL
* MongoDB
* Kafka
* Cassandra
* Elasticsearch
* Redis Clusters

---

# Deployment vs StatefulSet

| Feature          | Deployment     | StatefulSet           |
| ---------------- | -------------- | --------------------- |
| Pod names        | Random         | Stable and ordered    |
| Startup order    | Parallel       | Ordered               |
| Shutdown order   | Random         | Reverse ordered       |
| Storage          | Shared PVC     | Dedicated PVC per Pod |
| Network identity | Dynamic        | Stable DNS            |
| Best for         | Stateless apps | Stateful apps         |

Example:

Deployment Pods:

```bash
nginx-deploy-5b4f8b7d9f-abcde
nginx-deploy-5b4f8b7d9f-fghij
nginx-deploy-5b4f8b7d9f-klmno
```

StatefulSet Pods:

```bash
web-0
web-1
web-2
```

---

# Why Random Pod Names Are a Problem

Database clusters often maintain communication between specific nodes.

For example:

```text
db-0 → Primary
db-1 → Replica
db-2 → Replica
```

If a Pod gets recreated with a new random name, other nodes cannot reliably locate it.

StatefulSets solve this by ensuring:

```text
db-0 always remains db-0
db-1 always remains db-1
db-2 always remains db-2
```

---

# Task 1 – Deployment Example

## Deployment Manifest

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx-demo
  template:
    metadata:
      labels:
        app: nginx-demo
    spec:
      containers:
      - name: nginx
        image: nginx
```

Apply:

```bash
kubectl apply -f deployment.yaml
```

Check Pods:

```bash
kubectl get pods
```

Example Output:

```bash
nginx-deploy-5b4f8b7d9f-j2v8h
nginx-deploy-5b4f8b7d9f-l7pwx
nginx-deploy-5b4f8b7d9f-zx92m
```

Delete a Pod:

```bash
kubectl delete pod nginx-deploy-5b4f8b7d9f-j2v8h
```

A replacement Pod is created with a different name.

Cleanup:

```bash
kubectl delete deployment nginx-deploy
```
<img width="1347" height="477" alt="image" src="https://github.com/user-attachments/assets/e537c0ae-fcda-42b7-b1eb-63b396700a48" />

---

# Task 2 – Create a Headless Service

## What is a Headless Service?

A Headless Service does not provide a Cluster IP.

Instead, it creates DNS records for each Pod.

## Manifest

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-headless
spec:
  clusterIP: None
  selector:
    app: web
  ports:
  - port: 80
```

Apply:

```bash
kubectl apply -f headless-service.yaml
```

Verify:

```bash
kubectl get svc
```

Expected:

```bash
NAME             TYPE        CLUSTER-IP
nginx-headless   ClusterIP   None
```

Verification:

**CLUSTER-IP = None**
<img width="1374" height="250" alt="image" src="https://github.com/user-attachments/assets/23572e17-25a1-4fec-989a-f90bdce8c238" />

---

# Task 3 – Create StatefulSet

## StatefulSet Manifest

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: nginx-headless
  replicas: 3

  selector:
    matchLabels:
      app: web

  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx

        volumeMounts:
        - name: web-data
          mountPath: /usr/share/nginx/html

  volumeClaimTemplates:
  - metadata:
      name: web-data
    spec:
      accessModes:
      - ReadWriteOnce

      resources:
        requests:
          storage: 100Mi
```

Apply:

```bash
kubectl apply -f statefulset.yaml
```

Watch creation:

```bash
kubectl get pods -l app=web -w
```

Observe:

```text
web-0
web-1
web-2
```

Pods are created one at a time.

---

## Verify PVCs

```bash
kubectl get pvc
```

Expected:

```bash
web-data-web-0
web-data-web-1
web-data-web-2
```

PVC Naming Pattern:

```text
<volume-template-name>-<pod-name>
```

Example:

```text
web-data-web-0
```

---

# Task 4 – Stable Network Identity

Each StatefulSet Pod gets a stable hostname.

Pattern:

```text
<pod-name>.<service-name>.<namespace>.svc.cluster.local
```

Examples:

```text
web-0.nginx-headless.default.svc.cluster.local
web-1.nginx-headless.default.svc.cluster.local
web-2.nginx-headless.default.svc.cluster.local
```

Create BusyBox:

```bash
kubectl run dns-test --image=busybox:1.35 --rm -it -- sh
```

DNS Lookup:

```bash
nslookup web-0.nginx-headless.default.svc.cluster.local
```

```bash
nslookup web-1.nginx-headless.default.svc.cluster.local
```

```bash
nslookup web-2.nginx-headless.default.svc.cluster.local
```

Check Pod IPs:

```bash
kubectl get pods -o wide
```

Verification:

The resolved DNS IP should match the Pod IP.

---

# Task 5 – Persistent Storage

Write unique content:

```bash
kubectl exec web-0 -- sh -c \
"echo 'Data from web-0' > /usr/share/nginx/html/index.html"
```

Verify:

```bash
kubectl exec web-0 -- cat /usr/share/nginx/html/index.html
```

Output:

```text
Data from web-0
```

Delete Pod:

```bash
kubectl delete pod web-0
```

Wait until recreated:

```bash
kubectl get pods -w
```

Verify data:

```bash
kubectl exec web-0 -- cat /usr/share/nginx/html/index.html
```

Output:

```text
Data from web-0
```

### Result

Data remains available because the Pod reconnects to the same PVC.

---

# Task 6 – Ordered Scaling

Scale Up:

```bash
kubectl scale statefulset web --replicas=5
```

Creation Order:

```text
web-3
web-4
```

Scale Down:

```bash
kubectl scale statefulset web --replicas=3
```

Deletion Order:

```text
web-4
web-3
```

Check PVCs:

```bash
kubectl get pvc
```

Expected:

```text
web-data-web-0
web-data-web-1
web-data-web-2
web-data-web-3
web-data-web-4
```

Verification:

Even after scaling down to 3 Pods, all 5 PVCs remain.

This protects data from accidental loss.

---

# Task 7 – Cleanup

Delete StatefulSet:

```bash
kubectl delete statefulset web
```

Delete Service:

```bash
kubectl delete service nginx-headless
```

Check PVCs:

```bash
kubectl get pvc
```

PVCs still exist.

Delete PVCs manually:

```bash
kubectl delete pvc --all
```

Verification:

PVCs are NOT automatically deleted with StatefulSets.

---

# Key Learnings

* StatefulSets are designed for stateful applications.
* Pods receive stable names like `web-0`, `web-1`, and `web-2`.
* StatefulSets create Pods in order and terminate them in reverse order.
* Headless Services provide DNS records for each Pod.
* Each Pod receives its own dedicated PersistentVolumeClaim.
* Data survives Pod deletion because storage remains attached.
* Scaling down does not remove PVCs.
* Deleting a StatefulSet does not delete PVCs.
* StatefulSets are ideal for databases and distributed systems.

---

# Screenshots to Add

### 1. StatefulSet Pods

```bash
kubectl get pods
```

### 2. PVCs

```bash
kubectl get pvc
```

### 3. Headless Service

```bash
kubectl get svc
```

### 4. DNS Resolution

```bash
nslookup web-0.nginx-headless.default.svc.cluster.local
```

### 5. Persistent Data Verification

```bash
kubectl exec web-0 -- cat /usr/share/nginx/html/index.html
```

### 6. Ordered Scaling

```bash
kubectl scale statefulset web --replicas=5
kubectl scale statefulset web --replicas=3
```

---

# Conclusion

StatefulSets solve problems that Deployments cannot handle. They provide stable identities, predictable networking, ordered deployment, and persistent storage. These capabilities make StatefulSets the preferred Kubernetes workload for databases, message queues, and distributed systems.
