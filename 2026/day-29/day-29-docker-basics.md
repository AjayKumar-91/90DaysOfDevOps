**Task 1: What is Docker?**

**What is a container and why do we need them?**

**What is a container**

A container is a lightweight, isolated environment that runs an application with everything it needs to work.

Your application code

Runtime (Java, Node, Python, etc.)

Libraries & dependencies

System tools

All packed together and run consistently on any system.

**Why Do We Need Containers?**

“Works on my machine” problem

**Without containers:**

App works on laptop

Fails on server

**With containers:**

Same container runs everywhere


**Better resource usage**

**Containers:**

Share OS kernel

Use less RAM & CPU

Run more apps on same machine

Dockerfile → Image → Container → Running App

**Containers in Docker**

**Docker uses:**

Images → templates

Containers → running apps

Built by Docker

**Interview - Answer**

A container is a lightweight, isolated environment that packages an application with its dependencies, ensuring consistent behavior across development, testing, and

production systems. Containers are needed to eliminate environment issues, improve deployment speed, and efficiently use system resources.


**Containers vs Virtual Machines — what's the real difference?**

**Virtual Machine (VM)**

Like buying a full computer

Has its own OS

Heavy & slow to start

Example:

Your laptop → VirtualBox → Windows VM → App


**Container**

Like installing an app

No new OS, uses the same OS

Light & very fast

Example: Your laptop → Docker → App


Docker uses a client-server architecture where the primary work of building, running, and distributing containers is handled by a background service. 

**The core components of this architecture include:**

Docker Client: The primary way users interact with Docker. It is a command-line interface (CLI) or graphical tool (like Docker Desktop) that translates user commands into 

REST API requests.

Docker Daemon (dockerd): The "brain" of the system that runs on the host machine. It listens for API requests from the client and manages all Docker objects, including 

images, containers, networks, and volumes.

Docker Images: Read-only, immutable templates that serve as the blueprint for creating containers. They contain the application code, libraries, and dependencies needed for 

an application to run.

Docker Containers: The live, runnable instances of an image. Each container is an isolated environment that shares the host OS kernel but has its own unique filesystem and 

network space.

Docker Registry: A centralized storage system for sharing and distributing Docker images. Docker Hub is the default public registry, but organizations often use private 

registries like AWS ECR or Google Artifact Registry.

**Docker architecture**

<img width="1233" height="651" alt="image" src="https://github.com/user-attachments/assets/08be5fdd-4955-4ce4-8c5b-2e5f58098733" />

<img width="1400" height="1016" alt="image" src="https://github.com/user-attachments/assets/d345fb42-80fc-4340-bcc0-7e7775a80fbd" />

Docker works like a manager–worker system.

Docker Client is the speaker.

I type commands like docker build or docker run. The client just sends these instructions.

Docker Daemon is the doer.

It receives the instructions and actually builds images, starts containers, and manages everything in the background.

Docker Images are ready-made templates.

An image contains the app, libraries, and runtime needed to run something.

Docker Containers are running apps.

A container is created from an image and runs the application in isolation.

Docker Registry is a storehouse.

Images are downloaded from or uploaded to the registry when needed.


**Task 2: Install Docker**

**Install Docker on your machine (or use a cloud instance)**

**Verify the installation**

<img width="1600" height="710" alt="image" src="https://github.com/user-attachments/assets/7cf98737-3e80-419a-a589-80f5d3595176" />

**Run the hello-world container**

<img width="1294" height="558" alt="image" src="https://github.com/user-attachments/assets/e22662de-d1be-4f03-a50f-3e9f967fb8be" />

**What Happened?**

Docker checked for the image locally

Pulled image from Docker Hub

Created container

Executed it

Printed message

Stopped container


**Task 3: Run Real Containers**

**Run an Nginx container and access it in your browser**

<img width="1600" height="161" alt="image" src="https://github.com/user-attachments/assets/a6151135-71d7-468a-88ca-ac8f6299df36" />
<img width="1600" height="430" alt="image" src="https://github.com/user-attachments/assets/1e208cf6-4be2-4b72-9997-b8b6a5d61838" />


**Run an Ubuntu container in interactive mode — explore it like a mini Linux machine**

<img width="1600" height="765" alt="image" src="https://github.com/user-attachments/assets/8b021849-32f7-4b77-8c96-6940c0696336" />


**List all running containers**

<img width="1600" height="88" alt="image" src="https://github.com/user-attachments/assets/9f43d5c3-55dc-491d-a443-1cf526ab1dc1" />


**List all containers (including stopped ones)**

<img width="1600" height="138" alt="image" src="https://github.com/user-attachments/assets/351fdaaa-ade1-4257-a1c4-65a44272c121" />


**Stop and remove a container**

<img width="1600" height="150" alt="image" src="https://github.com/user-attachments/assets/7fa36f89-3580-42f6-a3bb-b3848a99e5fb" />


**Task 4: Explore**

**Run a container in detached mode — what's different?**

Runs container in background

Terminal is free

<img width="1186" height="65" alt="image" src="https://github.com/user-attachments/assets/a90a907c-d23d-47bd-8f02-3b243305fb80" />


**Give a container a custom name**

<img width="1364" height="69" alt="image" src="https://github.com/user-attachments/assets/c32603f1-476b-4dc8-a841-c68015275099" />


**Map a port from the container to your host**

Host Port → 9090
Container Port → 80

<img width="1412" height="88" alt="image" src="https://github.com/user-attachments/assets/0ff3bba5-e634-414b-920f-33b62caaa7fd" />



**Check logs of a running container**

<img width="1122" height="409" alt="image" src="https://github.com/user-attachments/assets/c384c30a-4818-44e1-8dfa-4cb61eb56246" />


**Run a command inside a running container**

<img width="1595" height="127" alt="image" src="https://github.com/user-attachments/assets/23b5db2d-f35e-47b9-a3fb-d6237cf9ba40" />




**Why Docker Matters in DevOps**

Used in CI/CD pipelines

Required for Kubernetes

Enables microservices

Makes deployments consistent

Essential for cloud-native apps

For Java Developers:

Package Spring Boot app as Docker image

Run anywhere (AWS, Azure, GCP)

Use in Kubernetes clusters



