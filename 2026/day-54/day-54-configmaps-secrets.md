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




