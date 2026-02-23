**Day 30 – Docker Images & Container Lifecycle**

**Task 1: Docker Images**

Pull the nginx, ubuntu, and alpine images from Docker Hub

<img width="1600" height="448" alt="image" src="https://github.com/user-attachments/assets/dfbc06e3-625e-4def-81d0-cb2edfdab529" />


List all images on your machine — note the sizes

<img width="956" height="149" alt="image" src="https://github.com/user-attachments/assets/1d517bc4-5bad-4658-a657-4cf87a27e96b" />

Compare ubuntu vs alpine — why is one much smaller?

Why is Alpine Smaller?

Minimal Linux distribution

No extra packages

Designed for containers

Uses musl libc instead of glibc

Ubuntu contains:

Full OS tools

More libraries

Larger base filesystem


**Inspect an image — what information can you see?**

<img width="1600" height="785" alt="image" src="https://github.com/user-attachments/assets/4b85395f-5e92-446b-ac9f-4f4711275330" />

**Remove an image you no longer need**

<img width="1074" height="117" alt="image" src="https://github.com/user-attachments/assets/fd562557-0380-4ac3-a896-22d8b1b14550" />



**Task 2: Image Layers**

Run docker image history nginx — what do you see?

<img width="1263" height="407" alt="image" src="https://github.com/user-attachments/assets/f21b5eb8-b887-4268-a99e-fcd37fcc8aa2" />


Each line is a layer. Note how some layers show sizes and some show 0B

Write in your notes: What are layers and why does Docker use them?

What are Layers?

Each Docker image is built in layers

Each Dockerfile instruction creates a layer

Layers are:

Read-only

Cached

Reusable

Why Docker Uses Layers?

Faster builds (layer caching)

Saves disk space

Efficient image distribution

Shared between multiple images

If two images use same base layer → Docker stores it only once.

**Task 3: Container Lifecycle**

Practice the full lifecycle on one container:

Create a container (without starting it)

Start the container

Pause it and check status

Unpause it

Stop it

Restart it

Kill it

Remove it

Check docker ps -a after each step — observe the state changes.

<img width="1278" height="481" alt="image" src="https://github.com/user-attachments/assets/24742323-3431-47e9-9409-9c34eba71213" />



**Task 4: Working with Running Containers**

**Run an Nginx container in detached mode**

<img width="1422" height="120" alt="image" src="https://github.com/user-attachments/assets/22eeeb0b-90c5-4dfd-a99d-721052ec0eca" />

<img width="1600" height="305" alt="image" src="https://github.com/user-attachments/assets/8e96e920-9cfd-436b-964e-c53ad2077eef" />


**View its logs**

<img width="1600" height="573" alt="image" src="https://github.com/user-attachments/assets/5699d764-5128-4ecb-8e36-440bdd001fd2" />


**View real-time logs (follow mode)**

<img width="1600" height="630" alt="image" src="https://github.com/user-attachments/assets/d3c69bdf-8874-40c8-8ae4-bcfe33c83edd" />


**Exec into the container and look around the filesystem**

<img width="1600" height="218" alt="image" src="https://github.com/user-attachments/assets/b23ec7f6-3117-46ee-bb44-41618a3b4892" />


**Run a single command inside the container without entering it**

<img width="1597" height="496" alt="image" src="https://github.com/user-attachments/assets/561fa3c4-2f1a-4017-9af5-8500550fc1c4" />


Inspect the container — find its IP address, port mappings, and mounts

<img width="1600" height="711" alt="image" src="https://github.com/user-attachments/assets/da83064d-58cd-4b86-941a-9ff8b6bf1174" />


**Task 5: Cleanup**

Stop all running containers in one command

Remove all stopped containers in one command

Remove unused images

Check how much disk space Docker is using

<img width="1600" height="733" alt="image" src="https://github.com/user-attachments/assets/cb86c64b-e806-4486-8b0e-d0235e304c26" />



Docker Images vs Containers
🔹 What is a Docker Image?

A Docker Image is a read-only blueprint.

It contains:

OS layer

Application code

Dependencies

Configuration

🔹 What is a Docker Container?

A Container is a running instance of an image.

Image = Class

Container = Object

👉 One image can create many container



