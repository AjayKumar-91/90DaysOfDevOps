# Kubernetes Manifest Basics

Every manifest has four required top-level fields:

apiVersion: v1       # API version to use
kind: Pod            # Resource type
metadata:            # Identity of the resource
  name: my-pod
  labels:
    app: my-app
spec:                # Desired state (containers, images, ports)
  containers:
    - name: my-container
      image: nginx:latest
      ports:
        - containerPort: 80

apiVersion → v1 for Pods

kind → Pod, Deployment, Service, etc.

metadata → name (required), labels (optional but useful for filtering)

spec → container definitions, image, ports, commands



        
