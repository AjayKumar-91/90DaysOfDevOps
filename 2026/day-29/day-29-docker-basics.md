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


