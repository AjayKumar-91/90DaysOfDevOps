# Day 55 – Kubernetes Persistent Volumes (PV) and Persistent Volume Claims (PVC)

## Objective

Learn why container storage is ephemeral and how Kubernetes Persistent Volumes (PV) and Persistent Volume Claims (PVC) provide durable storage that survives Pod restarts and deletions.

---

# Why Containers Need Persistent Storage

Containers are designed to be ephemeral.

When a Pod is deleted:

* Container filesystem is destroyed
* Data stored inside the container is lost
* New Pods start with a fresh filesystem

This behavior is fine for stateless applications but causes problems for:

* Databases
* Log storage
* File uploads
* Application state

Kubernetes solves this problem using Persistent Volumes (PV) and Persistent Volume Claims (PVC).

---

# Task 1: Demonstrate Data Loss with emptyDir

## Pod Manifest

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ephemeral-pod
spec:
  containers:
  - name: writer
    image: busybox
    command:
      - sh
      - -c
      - |
        echo "Created at $(date)" > /data/message.txt
        sleep 3600
    volumeMounts:
    - name: temp-storage
      mountPath: /data

  volumes:
  - name: temp-storage
    emptyDir: {}
```

## Apply Pod

```bash
kubectl apply -f ephemeral-pod.yaml
```

## Verify Data

```bash
kubectl exec -it ephemeral-pod -- cat /data/message.txt
```

Example:

```text
Created at Thu Jun 19 10:15:22 UTC 2026
```

## Delete and Recreate

```bash
kubectl delete pod ephemeral-pod
kubectl apply -f ephemeral-pod.yaml
```

Check again:

```bash
kubectl exec -it ephemeral-pod -- cat /data/message.txt
```

Example:

```text
Created at Thu Jun 19 10:18:41 UTC 2026
```
<img width="1361" height="291" alt="image" src="https://github.com/user-attachments/assets/a912cf66-3607-4614-9436-50f91ccada46" />

## Observation

The timestamp changed because the previous data was deleted along with the Pod.

### Verification

**Timestamp is different after recreation.**

This proves container storage is ephemeral.

---

# Task 2: Create a PersistentVolume (Static Provisioning)

## PersistentVolume Manifest

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: manual-pv
spec:
  capacity:
    storage: 1Gi
  storageClassName: manual
  
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /tmp/k8s-pv-data
```

## Apply

```bash
kubectl apply -f pv.yaml
```

## Verify

```bash
kubectl get pv
```

Example:

```text
NAME        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS
manual-pv   1Gi        RWO            Retain           Available
```
<img width="1357" height="167" alt="image" src="https://github.com/user-attachments/assets/645a0734-410b-4435-ab38-e1d8ec6e1999" />


### Verification

**PV Status: Available**

---

# Access Modes

## ReadWriteOnce (RWO)

Volume can be mounted as read-write by one node.

```text
Single Node → Read + Write
```

## ReadOnlyMany (ROX)

Volume can be mounted read-only by multiple nodes.

```text
Many Nodes → Read Only
```

## ReadWriteMany (RWX)

Volume can be mounted read-write by multiple nodes.

```text
Many Nodes → Read + Write
```

---

# Task 3: Create a PersistentVolumeClaim

## PVC Manifest

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: manual-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: manual
  
  resources:
    requests:
      storage: 500Mi
```

## Apply

```bash
kubectl apply -f pvc.yaml
```

## Verify

```bash
kubectl get pvc
kubectl get pv
```

Example:

```text
kubectl get pvc

NAME         STATUS   VOLUME      CAPACITY
manual-pvc   Bound    manual-pv   1Gi
```

```text
kubectl get pv

NAME        STATUS
manual-pv   Bound
```
<img width="1355" height="342" alt="image" src="https://github.com/user-attachments/assets/6bd22962-73b9-49e9-98d3-1ee1d1e32a48" />


### Verification

**VOLUME column shows: manual-pv**

The PVC successfully bound to the PV.

---

# Relationship Between PV and PVC

```text
Application Pod
       │
       ▼
PersistentVolumeClaim
       │
       ▼
PersistentVolume
       │
       ▼
Physical Storage
```

PVC requests storage.

PV provides storage.

Kubernetes automatically binds them.

---

# Task 4: Use PVC in a Pod

## Pod Manifest

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pv-pod
spec:
  containers:
  - name: writer
    image: busybox
    command:
      - sh
      - -c
      - |
        echo "Written by $(hostname) at $(date)" >> /data/message.txt
        sleep 3600

    volumeMounts:
    - mountPath: /data
      name: storage

  volumes:
  - name: storage
    persistentVolumeClaim:
      claimName: manual-pvc
```

## Apply

```bash
kubectl apply -f pv-pod.yaml
```

## Check Data

```bash
kubectl exec -it pv-pod -- cat /data/message.txt
```

Example:

```text
Written by pv-pod at Thu Jun 19 11:00:01 UTC 2026
```

## Delete Pod

```bash
kubectl delete pod pv-pod
kubectl apply -f pv-pod.yaml
```

Check again:

```bash
kubectl exec -it pv-pod -- cat /data/message.txt
```

Example:

```text
Written by pv-pod at Thu Jun 19 11:00:01 UTC 2026
Written by pv-pod at Thu Jun 19 11:04:44 UTC 2026
```

### Verification

**Yes, the file contains data from both Pod instances.**

Persistent storage survived Pod deletion.

---

# Task 5: StorageClasses and Dynamic Provisioning

## View Storage Classes

```bash
kubectl get storageclass
```

Example:

```text
NAME                 PROVISIONER                RECLAIMPOLICY
standard (default)   rancher.io/local-path      Delete
```

## Describe

```bash
kubectl describe storageclass standard
```

Example Output:

```text
Provisioner:          rancher.io/local-path
ReclaimPolicy:        Delete
VolumeBindingMode:    WaitForFirstConsumer
```

### Important Fields

#### Provisioner

Creates storage automatically.

#### Reclaim Policy

Determines what happens after PVC deletion.

#### Volume Binding Mode

Controls when a volume is created and attached.

### Verification

**Default StorageClass: standard**

(Your cluster may differ.)

---

# Static vs Dynamic Provisioning

## Static Provisioning

Administrator creates PV first.

```text
Admin Creates PV
        ↓
Developer Creates PVC
        ↓
PV Bound
```

## Dynamic Provisioning

Developer only creates PVC.

StorageClass automatically creates PV.

```text
Developer Creates PVC
        ↓
StorageClass Creates PV
        ↓
PVC Bound
```

---

# Task 6: Dynamic Provisioning

## PVC Manifest

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dynamic-pvc
spec:
  storageClassName: standard

  accessModes:
    - ReadWriteOnce

  resources:
    requests:
      storage: 500Mi
```

## Apply

```bash
kubectl apply -f dynamic-pvc.yaml
```

## Verify

```bash
kubectl get pvc
kubectl get pv
```

Example:

```text
NAME                                       STATUS
manual-pv                                  Bound
pvc-a1b2c3d4-e5f6-7890-abcd-1234567890ab   Bound
```

The second PV was created automatically.

### Verification

Two PVs now exist:

| PV              | Type    |
| --------------- | ------- |
| manual-pv       | Static  |
| pvc-a1b2c3d4... | Dynamic |

---

# Using Dynamic PVC in a Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: dynamic-pod
spec:
  containers:
  - name: app
    image: busybox
    command:
      - sh
      - -c
      - |
        echo "Dynamic PV Test $(date)" >> /data/test.txt
        sleep 3600

    volumeMounts:
    - mountPath: /data
      name: storage

  volumes:
  - name: storage
    persistentVolumeClaim:
      claimName: dynamic-pvc
```

Apply:

```bash
kubectl apply -f dynamic-pod.yaml
```

Verify:

```bash
kubectl exec -it dynamic-pod -- cat /data/test.txt
```

Data persists successfully.

---

# Task 7: Cleanup

## Delete Pods

```bash
kubectl delete pod pv-pod dynamic-pod
```

## Delete PVCs

```bash
kubectl delete pvc manual-pvc dynamic-pvc
```

## Check PVs

```bash
kubectl get pv
```

Example:

```text
manual-pv    Released
```

Dynamic PV is already deleted.

---

# Reclaim Policies

## Retain

```text
PVC Deleted
      ↓
PV Released
      ↓
Data Kept
```

Manual cleanup required.

---

## Delete

```text
PVC Deleted
      ↓
PV Deleted
      ↓
Data Deleted
```

Automatic cleanup.

---

# Verification

| PV         | Result              |
| ---------- | ------------------- |
| manual-pv  | Retained (Released) |
| dynamic PV | Auto Deleted        |

Reason:

* Manual PV used `Retain`
* Dynamic PV used StorageClass policy `Delete`

---

# PV Lifecycle

```text
Available
    ↓
Bound
    ↓
Released
    ↓
Deleted
```

---

# Key Learnings

* Containers are ephemeral and lose data when Pods are deleted.
* `emptyDir` storage exists only for the lifetime of a Pod.
* Persistent Volumes provide durable storage.
* Persistent Volume Claims request storage from PVs.
* PVs are cluster-scoped resources.
* PVCs are namespace-scoped resources.
* Static provisioning requires manual PV creation.
* Dynamic provisioning automatically creates PVs using StorageClasses.
* Access modes control how volumes can be mounted.
* Reclaim policies determine what happens after PVC deletion.
* Persistent storage allows data to survive Pod restarts and recreations.

---

# Conclusion

Today I learned how Kubernetes handles persistent storage using Persistent Volumes and Persistent Volume Claims. I demonstrated data loss with an ephemeral volume, implemented static provisioning using a manually created PV and PVC, and explored dynamic provisioning using StorageClasses. Persistent storage ensures that application data survives Pod failures, restarts, and recreations.
