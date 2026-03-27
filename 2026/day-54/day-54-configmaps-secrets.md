# Task 1: Create a ConfigMap from Literals

Use kubectl create configmap with --from-literal to create a ConfigMap called app-config with keys APP_ENV=production, APP_DEBUG=false, and APP_PORT=8080

Inspect it with kubectl describe configmap app-config and kubectl get configmap app-config -o yaml

Notice the data is stored as plain text — no encoding, no encryption

Verify: Can you see all three key-value pairs?

<img width="1918" height="752" alt="image" src="https://github.com/user-attachments/assets/fa87050b-bea9-4df7-83d7-321e4604b522" />

<img width="1918" height="345" alt="image" src="https://github.com/user-attachments/assets/2a972e7a-42e7-406c-8eae-6bd9f11af93d" />


# Task 2: Create a ConfigMap from a File

Write a custom Nginx config file that adds a /health endpoint returning "healthy"

Create a ConfigMap from this file using kubectl create configmap nginx-config --from-file=default.conf=<your-file>

The key name (default.conf) becomes the filename when mounted into a Pod

Verify: Does kubectl get configmap nginx-config -o yaml show the file contents?

<img width="1917" height="675" alt="image" src="https://github.com/user-attachments/assets/38d18446-c394-40a7-b009-2a869b8ea77c" />


# Task 3: Use ConfigMaps in a Pod

Write a Pod manifest that uses envFrom with configMapRef to inject all keys from app-config as environment variables. Use a busybox container that prints the values.

Write a second Pod manifest that mounts nginx-config as a volume at /etc/nginx/conf.d. Use the nginx image.

Test that the mounted config works: kubectl exec <pod> -- curl -s http://localhost/health

Use environment variables for simple key-value settings. Use volume mounts for full config files.

Verify: Does the /health endpoint respond?

<img width="1918" height="972" alt="image" src="https://github.com/user-attachments/assets/89f08d45-1554-4d96-a343-de3c7d82acad" />

<img width="1918" height="682" alt="image" src="https://github.com/user-attachments/assets/80d512b0-efd3-4910-b5db-be7d207eb33c" />


# Task 4: Create a Secret

Use kubectl create secret generic db-credentials with --from-literal to store DB_USER=admin and DB_PASSWORD=s3cureP@ssw0rd

Inspect with kubectl get secret db-credentials -o yaml — the values are base64-encoded

Decode a value: echo '<base64-value>' | base64 --decode

base64 is encoding, not encryption. Anyone with cluster access can decode Secrets. The real advantages are RBAC separation, tmpfs storage on nodes, and optional 

encryption at rest.

Verify: Can you decode the password back to plaintext?

<img width="1918" height="527" alt="image" src="https://github.com/user-attachments/assets/30956d04-63d3-46c1-b3b4-2456b3eb1051" />



#Task 5: Use Secrets in a Pod 

Write a Pod manifest that injects DB_USER as an environment variable using secretKeyRef

In the same Pod, mount the entire db-credentials Secret as a volume at /etc/db-credentials with readOnly: true

Verify: each Secret key becomes a file, and the content is the decoded plaintext value

Verify: Are the mounted file values plaintext or base64?

<img width="1918" height="802" alt="image" src="https://github.com/user-attachments/assets/a59cacd2-1b88-484b-9ba0-db644e88f1b1" />



# Task 6: Update a ConfigMap and Observe Propagation

Create a ConfigMap live-config with a key message=hello

Write a Pod that mounts this ConfigMap as a volume and reads the file in a loop every 5 seconds

Update the ConfigMap: kubectl patch configmap live-config --type merge -p '{"data":{"message":"world"}}'

Wait 30-60 seconds — the volume-mounted value updates automatically

Environment variables from earlier tasks do NOT update — they are set at pod startup only

Verify: Did the volume-mounted value change without a pod restart?


<img width="1918" height="520" alt="image" src="https://github.com/user-attachments/assets/e6bcae85-19e5-4c81-a0c7-24c7f7f1cfae" />


<img width="1913" height="140" alt="image" src="https://github.com/user-attachments/assets/1ceada02-1df8-41a7-a3c9-3b35038f2cbe" />


# Task 7: Clean Up

Delete all pods, ConfigMaps, and Secrets you created.

## Delete all Pods created

kubectl delete pod busybox-env nginx-config-pod secret-pod live-config-pod

## Delete all ConfigMaps created

kubectl delete configmap app-config nginx-config live-config

## Delete all Secrets created

kubectl delete secret db-credentials

## Verify cleanup

kubectl get pods

kubectl get configmap

kubectl get secret

<img width="1918" height="633" alt="image" src="https://github.com/user-attachments/assets/b839a97a-3ae1-4dfc-b08d-4b0619382307" />


## ConfigMaps and Secrets

- **ConfigMaps:** Store non-sensitive configuration (key-value pairs or files).  
- **Secrets:** Store sensitive data like passwords and API keys. Encoded in base64, can be optionally encrypted at rest.

## Environment Variables vs Volume Mounts

- **Env Variables:** Easy key-value injection, **static at pod start**.  
- **Volume Mounts:** Full files, automatically updated if ConfigMap or Secret changes.

## Base64 Encoding

- Secrets are **base64-encoded**, not encrypted.  
- Anyone with cluster access can decode:  
  ```bash
  echo '<base64-value>' | base64 --decode
