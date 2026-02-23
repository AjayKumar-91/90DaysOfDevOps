**Day 30 – Docker Images & Container Lifecycle**

**Task 1: Docker Images**

Pull the nginx, ubuntu, and alpine images from Docker Hub

<img width="1600" height="448" alt="image" src="https://github.com/user-attachments/assets/dfbc06e3-625e-4def-81d0-cb2edfdab529" />


List all images on your machine — note the sizes

<img width="956" height="149" alt="image" src="https://github.com/user-attachments/assets/1d517bc4-5bad-4658-a657-4cf87a27e96b" />

<img width="1600" height="863" alt="image" src="https://github.com/user-attachments/assets/5d6a44d7-b0b4-4aa1-8136-e582b3b33800" />

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

<img width="1600" height="785" alt="image" src="https://github.com/user-attachments/assets/9abab569-2df4-47ed-99b8-75b7aa310d2b" />


**Remove an image you no longer need**

<img width="1395" height="453" alt="image" src="https://github.com/user-attachments/assets/70dc1457-977d-4c89-b292-8594abfbff11" />



**Task 2: Image Layers**

Run docker image history nginx — what do you see?

Each line is a layer. Note how some layers show sizes and some show 0B

Write in your notes: What are layers and why does Docker use them?


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




**Task 4: Working with Running Containers**

Run an Nginx container in detached mode

View its logs

View real-time logs (follow mode)

Exec into the container and look around the filesystem

Run a single command inside the container without entering it

Inspect the container — find its IP address, port mappings, and mounts



**Task 5: Cleanup**

Stop all running containers in one command

Remove all stopped containers in one command

Remove unused images

Check how much disk space Docker is using




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



