### Task 1: Understand the Problem
1. Create a Deployment with 3 replicas using nginx
2. Check the pod names — they are random (`app-xyz-abc`)
3. Delete a pod and notice the replacement gets a different random name

This is fine for web servers but not for databases where you need stable identity.

| Feature | Deployment | StatefulSet |
|---|---|---|
| Pod names | Random | Stable, ordered (`app-0`, `app-1`) |
| Startup order | All at once | Ordered: pod-0, then pod-1, then pod-2 |
| Storage | Shared PVC | Each pod gets its own PVC |
| Network identity | No stable hostname | Stable DNS per pod |

Delete the Deployment before moving on.

**Verify:** Why would random pod names be a problem for a database cluster?

<img width="1918" height="778" alt="image" src="https://github.com/user-attachments/assets/7203cb1b-b1ff-4f16-b2b2-35b25880f9c1" />


---

### Task 2: Create a Headless Service
1. Write a Service manifest with `clusterIP: None` — this is a Headless Service
2. Set the selector to match the labels you will use on your StatefulSet pods
3. Apply it and confirm CLUSTER-IP shows `None`

A Headless Service creates individual DNS entries for each pod instead of load-balancing to one IP. StatefulSets require this.

**Verify:** What does the CLUSTER-IP column show?

<img width="1918" height="450" alt="image" src="https://github.com/user-attachments/assets/981c9241-cbaf-4caa-9e15-f0d200868b46" />


---

### Task 3: Create a StatefulSet
1. Write a StatefulSet manifest with `serviceName` pointing to your Headless Service
2. Set replicas to 3, use the nginx image
3. Add a `volumeClaimTemplates` section requesting 100Mi of ReadWriteOnce storage
4. Apply and watch: `kubectl get pods -l <your-label> -w`

Observe ordered creation — `web-0` first, then `web-1` after `web-0` is Ready, then `web-2`.

Check the PVCs: `kubectl get pvc` — you should see `web-data-web-0`, `web-data-web-1`, `web-data-web-2` (names follow the pattern `<template-name>-<pod-name>`).

**Verify:** What are the exact pod names and PVC names?

<img width="1917" height="786" alt="image" src="https://github.com/user-attachments/assets/2ecf6eb8-942e-48b5-8f40-400b239e5baf" />

<img width="1918" height="197" alt="image" src="https://github.com/user-attachments/assets/b49ef27f-5432-4036-9a28-83352d3a5efe" />

---

### Task 4: Stable Network Identity
Each StatefulSet pod gets a DNS name: `<pod-name>.<service-name>.<namespace>.svc.cluster.local`

1. Run a temporary busybox pod and use `nslookup` to resolve `web-0.<your-headless-service>.default.svc.cluster.local`
2. Do the same for `web-1` and `web-2`
3. Confirm the IPs match `kubectl get pods -o wide`

**Verify:** Does the nslookup IP match the pod IP?

<img width="1918" height="760" alt="image" src="https://github.com/user-attachments/assets/f16d2ffc-3ed5-4507-87c6-c19819a39fd8" />


---

### Task 5: Stable Storage — Data Survives Pod Deletion
1. Write unique data to each pod: `kubectl exec web-0 -- sh -c "echo 'Data from web-0' > /usr/share/nginx/html/index.html"`
2. Delete `web-0`: `kubectl delete pod web-0`
3. Wait for it to come back, then check the data — it should still be "Data from web-0"

The new pod reconnected to the same PVC.

**Verify:** Is the data identical after pod recreation?

<img width="1918" height="368" alt="image" src="https://github.com/user-attachments/assets/694c3543-a4d2-4c22-a086-dae78d5a634b" />


---

### Task 6: Ordered Scaling
1. Scale up to 5: `kubectl scale statefulset web --replicas=5` — pods create in order (web-3, then web-4)
2. Scale down to 3 — pods terminate in reverse order (web-4, then web-3)
3. Check `kubectl get pvc` — all five PVCs still exist. Kubernetes keeps them on scale-down so data is preserved if you scale back up.

**Verify:** After scaling down, how many PVCs exist?

<img width="1918" height="877" alt="image" src="https://github.com/user-attachments/assets/f0bae637-7b8a-45a9-b607-c3d7e303f8a3" />


---

### Task 7: Clean Up
1. Delete the StatefulSet and the Headless Service
2. Check `kubectl get pvc` — PVCs are still there (safety feature)
3. Delete PVCs manually

**Verify:** Were PVCs auto-deleted with the StatefulSet?

<img width="1735" height="303" alt="image" src="https://github.com/user-attachments/assets/3847fe56-2e83-44c5-b771-06ffd29b82b9" />


