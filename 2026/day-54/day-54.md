# Day 54 – Kubernetes ConfigMaps and Secrets

## Objective

Applications need configuration such as environment settings, database URLs, feature flags, and credentials. Hardcoding these values inside container images is not practical because every configuration change would require rebuilding and redeploying the image.

Kubernetes provides:

* **ConfigMaps** for non-sensitive configuration data.
* **Secrets** for sensitive information such as passwords, API keys, and tokens.

---

# Task 1: Create a ConfigMap from Literals

## Create ConfigMap

```bash
kubectl create configmap app-config \
  --from-literal=APP_ENV=production \
  --from-literal=APP_DEBUG=false \
  --from-literal=APP_PORT=8080
```

## Verify

```bash
kubectl describe configmap app-config
```

```bash
kubectl get configmap app-config -o yaml
```

### Output

```yaml
data:
  APP_DEBUG: "false"
  APP_ENV: production
  APP_PORT: "8080"
```

### Observation

ConfigMap values are stored as plain text and are not encrypted.
<img width="1691" height="657" alt="image" src="https://github.com/user-attachments/assets/c4c38cc6-cdd6-40f4-9f82-f63e4e047a28" />
<img width="1542" height="296" alt="image" src="https://github.com/user-attachments/assets/6c75b78f-e716-4f88-891f-77f2a9fab44d" />

---

# Task 2: Create a ConfigMap from a File

## Create Nginx Configuration File

### default.conf

```nginx
server {
    listen 80;

    location /health {
        return 200 "healthy";
        add_header Content-Type text/plain;
    }
}
```

## Create ConfigMap

```bash
kubectl create configmap nginx-config --from-file=default.conf=default.conf
```

## Verify

```bash
kubectl get configmap nginx-config -o yaml
```

### Output

```yaml
data:
  default.conf: |
    server {
        listen 80;

        location /health {
            return 200 "healthy";
            add_header Content-Type text/plain;
        }
    }
```

<img width="1332" height="461" alt="image" src="https://github.com/user-attachments/assets/ea48572d-5d0d-43df-b5a5-092d6aa54e80" />
<img width="1361" height="572" alt="image" src="https://github.com/user-attachments/assets/018bb37e-279a-447a-b457-3a397ad1205a" />

---

# Task 3: Use ConfigMaps in Pods

## Inject ConfigMap as Environment Variables

### busybox-config-env.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: config-env-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh", "-c", "echo APP_ENV=$APP_ENV; echo APP_DEBUG=$APP_DEBUG; echo APP_PORT=$APP_PORT; sleep 3600"]
    envFrom:
    - configMapRef:
        name: app-config
```

### Deploy

```bash
kubectl apply -f busybox-config-env.yaml
```

### Verify

```bash
kubectl logs config-env-pod
```

Expected:

```text
APP_ENV=production
APP_DEBUG=false
APP_PORT=8080
```
<img width="1332" height="171" alt="image" src="https://github.com/user-attachments/assets/ed864a92-b14a-4634-a909-d021377c819c" />

---

## Mount ConfigMap as a Volume

### nginx-config-pod.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-config-pod
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80

    volumeMounts:
    - name: nginx-config-volume
      mountPath: /etc/nginx/conf.d

  volumes:
  - name: nginx-config-volume
    configMap:
      name: nginx-config
```

### Deploy

```bash
kubectl apply -f nginx-config-pod.yaml
```

### Verify

```bash
kubectl exec nginx-config-pod -- curl -s http://localhost/health
```

Expected:

```text
healthy
```
<img width="1672" height="120" alt="image" src="https://github.com/user-attachments/assets/ef22b1c3-2c46-4c95-bd8a-028834e80533" />

---

# Task 4: Create a Secret

## Create Secret

```bash
kubectl create secret generic db-credentials \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASSWORD='s3cureP@ssw0rd'
```

## Inspect Secret

```bash
kubectl get secret db-credentials -o yaml
```

Example:

```yaml
data:
  DB_PASSWORD: czNjdXJlUEBzc3cwcmQ=
  DB_USER: YWRtaW4=
```

## Decode Secret

```bash
echo 'czNjdXJlUEBzc3cwcmQ=' | base64 --decode
```

Output:

```text
s3cureP@ssw0rd
```

### Observation

Base64 is only encoding. It does not provide security because anyone with access can decode the value.

<img width="1482" height="432" alt="image" src="https://github.com/user-attachments/assets/6bf2503a-b9ca-4108-b992-295b856e0ba6" />

---

# Task 5: Use Secrets in a Pod

### secret-pod.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
spec:
  containers:
  - name: busybox
    image: busybox
    apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh", "-c", "echo DB_USER=$DB_USER; sleep 3600"]

    env:
    - name: DB_USER
      valueFrom:
        secretKeyRef:
          name: db-credentials
          key: DB_USER

    volumeMounts:
    - name: secret-volume
      mountPath: /etc/db-credentials
      readOnly: true

  volumes:
  - name: secret-volume
    secret:
      secretName: db-credentials

    env:
    - name: DB_USER
      valueFrom:
        secretKeyRef:
          name: db-credentials
          key: DB_USER

    volumeMounts:
    - name: secret-volume
      mountPath: /etc/db-credentials
      readOnly: true

  volumes:
  - name: secret-volume
    secret:
      secretName: db-credentials
```

## Deploy

```bash
kubectl apply -f secret-pod.yaml
```

## Verify Environment Variable

```bash
kubectl logs secret-pod
```

Expected:

```text
DB_USER=admin
```

## Verify Mounted Files

```bash
kubectl exec secret-pod -- ls /etc/db-credentials
```

Expected:

```text
DB_PASSWORD
DB_USER
```

```bash
kubectl exec secret-pod -- cat /etc/db-credentials/DB_PASSWORD
```

Expected:

```text
s3cureP@ssw0rd
```

### Observation

Mounted Secret files contain plaintext values, not Base64-encoded values.


<img width="1337" height="246" alt="image" src="https://github.com/user-attachments/assets/f372d1bf-5b59-4598-a6aa-05d6e49e80ab" />

---

# Task 6: Update a ConfigMap and Observe Propagation

## Create ConfigMap

```bash
kubectl create configmap live-config \
  --from-literal=message=hello
```

## Create Pod

### live-config-pod.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: live-config-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh", "-c", "while true; do cat /etc/live-config/message; echo ''; sleep 5; done"]

    volumeMounts:
    - name: config-volume
      mountPath: /config

  volumes:
  - name: config-volume
    configMap:
      name: live-config
```

## Deploy

```bash
kubectl apply -f live-config-pod.yaml
```

## Update ConfigMap

```bash
kubectl patch configmap live-config \
  --type merge \
  -p '{"data":{"message":"world"}}'
```

## Watch Logs

```bash
kubectl logs -f live-config-pod
```

Expected:

```text
hello
hello
hello
world
world
world
```
<img width="1346" height="527" alt="image" src="https://github.com/user-attachments/assets/e68c753d-5772-43c9-aa29-525da7721ce4" />

### Observation

Volume-mounted ConfigMaps automatically refresh.

Environment variables sourced from ConfigMaps do not refresh and require a Pod restart.

---

# ConfigMaps vs Secrets

| Feature               | ConfigMap                   | Secret                      |
| --------------------- | --------------------------- | --------------------------- |
| Purpose               | Non-sensitive configuration | Sensitive data              |
| Storage               | Plain text                  | Base64 encoded              |
| Environment Variables | Yes                         | Yes                         |
| Volume Mounts         | Yes                         | Yes                         |
| Encryption            | No                          | Optional encryption at rest |
| Examples              | Feature flags, ports, URLs  | Passwords, API keys, tokens |

---

# Environment Variables vs Volume Mounts

| Method                | Best For                             |
| --------------------- | ------------------------------------ |
| Environment Variables | Small key-value configuration        |
| Volume Mounts         | Configuration files and certificates |

## Environment Variables

Advantages:

* Easy access from applications.
* Simple key-value configuration.

Limitations:

* Values are fixed when the Pod starts.
* Changes require Pod restart.

## Volume Mounts

Advantages:

* Suitable for complete configuration files.
* Updates propagate automatically.

Limitations:

* Application may need to reload files.

---

# Why Base64 Is Not Encryption

Base64 simply converts binary data into ASCII text.

Example:

```bash
echo -n "admin" | base64
```

Output:

```text
YWRtaW4=
```

Anyone can decode it:

```bash
echo "YWRtaW4=" | base64 --decode
```

Output:

```text
admin
```

Therefore:

* Base64 hides data.
* Base64 does not secure data.
* Kubernetes Secrets rely on RBAC, node protections, and optional encryption-at-rest for security.

---

# Key Learnings

* Created ConfigMaps from literals and files.
* Injected ConfigMap values as environment variables.
* Mounted ConfigMaps as files inside Pods.
* Created Secrets using literals.
* Decoded Base64 Secret values.
* Consumed Secrets using environment variables and volumes.
* Learned that mounted Secret files contain plaintext values.
* Observed automatic ConfigMap updates for volume mounts.
* Learned that environment variables do not update without Pod restart.
* Understood why Base64 encoding is not encryption.

---

# Cleanup

```bash
kubectl delete pod config-env-pod
kubectl delete pod nginx-config-pod
kubectl delete pod secret-pod
kubectl delete pod live-config-pod

kubectl delete configmap app-config
kubectl delete configmap nginx-config
kubectl delete configmap live-config

kubectl delete secret db-credentials
```

---

# Conclusion

ConfigMaps and Secrets separate application configuration from container images, making deployments more flexible and secure. ConfigMaps are ideal for non-sensitive configuration, while Secrets should be used for credentials and sensitive data. Volume-mounted ConfigMaps and Secrets support dynamic updates, whereas environment variables remain static until a Pod restart.
