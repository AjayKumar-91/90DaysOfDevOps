# Task 1: See the Problem — Data Lost on Pod Deletion

Write a Pod manifest that uses an emptyDir volume and writes a timestamped message to /data/message.txt

Apply it, verify the data exists with kubectl exec

Delete the Pod, recreate it, check the file again — the old message is gone

Verify: Is the timestamp the same or different after recreation?

Verify: The timestamp changes after Pod recreation — data is lost.

<img width="1918" height="732" alt="image" src="https://github.com/user-attachments/assets/764c7ef9-e496-4899-827d-69cce121f7c4" />


# Task 2: Create a PersistentVolume (Static Provisioning)

Write a PV manifest with capacity: 1Gi, accessModes: ReadWriteOnce, persistentVolumeReclaimPolicy: Retain, and hostPath pointing to /tmp/k8s-pv-data

Apply it and check kubectl get pv — status should be Available

Access modes to know:

ReadWriteOnce (RWO) — read-write by a single node

ReadOnlyMany (ROX) — read-only by many nodes

ReadWriteMany (RWX) — read-write by many nodes

hostPath is fine for learning, not for production.

Verify: What is the STATUS of the PV?

Verify: STATUS should be Available.

<img width="1917" height="667" alt="image" src="https://github.com/user-attachments/assets/6653829d-c64c-4a6a-b87c-afd85675a763" />



# Task 3: Create a PersistentVolumeClaim

Write a PVC manifest requesting 500Mi of storage with ReadWriteOnce access

Apply it and check both kubectl get pvc and kubectl get pv

Both should show Bound — Kubernetes matched them by capacity and access mode

Verify: What does the VOLUME column in kubectl get pvc show?

Verify: STATUS = Bound, VOLUME column shows pv-static.

<img width="1918" height="696" alt="image" src="https://github.com/user-attachments/assets/f9ff5560-1a66-4535-b3cd-6293751141dc" />



# Task 4: Use the PVC in a Pod — Data That Survives

Write a Pod manifest that mounts the PVC at /data using persistentVolumeClaim.claimName

Write data to /data/message.txt, then delete and recreate the Pod

Check the file — it should contain data from both Pods

Verify: Does the file contain data from both the first and second Pod?

Verify: The file contains data from both the first and second Pod — data persists.

<img width="1918" height="902" alt="image" src="https://github.com/user-attachments/assets/b5cbb987-4870-429b-881d-675209481773" />



# Task 5: StorageClasses and Dynamic Provisioning

Run kubectl get storageclass and kubectl describe storageclass

Note the provisioner, reclaim policy, and volume binding mode

With dynamic provisioning, developers only create PVCs — the StorageClass handles PV creation automatically

Verify: What is the default StorageClass in your cluster?

Verify: Note the provisioner, reclaimPolicy, and volumeBindingMode. Default StorageClass is usually standard.

<img width="1918" height="437" alt="image" src="https://github.com/user-attachments/assets/e384f6b9-b78f-4391-8237-14fb995316f8" />


# Task 6: Dynamic Provisioning

Write a PVC manifest that includes storageClassName: standard (or your cluster's default)

Apply it — a PV should appear automatically in kubectl get pv

Use this PVC in a Pod, write data, verify it works

Verify: How many PVs exist now? Which was manual, which was dynamic?

Verify: A PV is created automatically. Use it in a Pod like in Task 4.

<img width="1918" height="731" alt="image" src="https://github.com/user-attachments/assets/ed48ed91-ffef-4a26-9d18-34491b801e24" />



# Task 7: Clean Up

Delete all pods first

Delete PVCs — check kubectl get pv to see what happened

The dynamic PV is gone (Delete reclaim policy). The manual PV shows Released (Retain policy).

Delete the remaining PV manually

Verify: Which PV was auto-deleted and which was retained? Why?

Verify:

Dynamic PV (Delete policy) → auto-deleted

Static PV (Retain policy) → Released, manual deletion needed

<img width="1918" height="802" alt="image" src="https://github.com/user-attachments/assets/2f48b52a-b070-4f1f-b7cd-078aa20d7560" />


# Day 55 – Persistent Volumes (PV) and Persistent Volume Claims (PVC)

## Why Containers Need Persistent Storage
Containers are ephemeral; data inside them disappears when Pods restart or die. Databases and logs need storage that survives Pod lifecycle.

## Persistent Volumes (PV)
A PV is a piece of storage in the cluster that has been provisioned by an administrator or dynamically by StorageClass. PVs are **cluster-wide** resources.

## Persistent Volume Claims (PVC)
A PVC is a request for storage by a user. Pods use PVCs as volumes. Kubernetes binds PVCs to PVs that satisfy the claim.

## Static vs Dynamic Provisioning
- **Static:** Admin creates PVs manually. PVCs are bound to these PVs.
- **Dynamic:** PVC specifies a StorageClass, which automatically creates a PV.

## Access Modes
- **ReadWriteOnce (RWO):** Single node read/write
- **ReadOnlyMany (ROX):** Multiple nodes read-only
- **ReadWriteMany (RWX):** Multiple nodes read/write

## Reclaim Policies
- **Retain:** Keep data after PVC deletion (manual cleanup needed)
- **Delete:** Delete the PV along with data after PVC deletion

## Demonstration Summary
1. Ephemeral Pod using `emptyDir` loses data on restart.
2. PV + PVC setup retains data across Pod deletions.
3. Dynamic provisioning automates PV creation with StorageClass.
4. Proper cleanup shows difference between Retain and Delete policies.

