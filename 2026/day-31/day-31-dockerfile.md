**Day 31 – Dockerfile: Build Your Own Images**

**Task 1: Your First Dockerfile**

Create a folder called my-first-image

Inside it, create a Dockerfile that:

Uses Ubuntu as the base image

Installs curl

Sets a default command to print "Hello from my custom image!"

Build the image and tag it my-ubuntu:v1

Run a container from your image

Verify: The message prints on docker run

<img width="1600" height="858" alt="image" src="https://github.com/user-attachments/assets/e4b100a1-8738-4b5e-ab9d-1d14b2d4c6d0" />

<img width="1371" height="179" alt="image" src="https://github.com/user-attachments/assets/5f7730ae-4373-4142-ad62-96860c7fd54e" />

<img width="1207" height="65" alt="image" src="https://github.com/user-attachments/assets/12ee1d36-a220-41ac-9890-1bcc3fd920e2" />



**Task 2: Dockerfile Instructions**

Create a new Dockerfile that uses all of these instructions:

FROM — base image

RUN — execute commands during build

COPY — copy files from host to image

WORKDIR — set working directory

EXPOSE — document the port

CMD — default command

Build and run it. Understand what each line does.

<img width="1600" height="788" alt="image" src="https://github.com/user-attachments/assets/dc9416f2-0620-44d5-bdd8-9390319fc32b" />

<img width="1331" height="260" alt="image" src="https://github.com/user-attachments/assets/77edcf4e-8e40-4422-bf1f-88c589ac0d76" />

<img width="1600" height="84" alt="image" src="https://github.com/user-attachments/assets/93010ecc-e7a9-4df4-a103-fe6af3fda71d" />


| Instruction | Meaning                             |
| ----------- | ----------------------------------- |
| FROM        | Base image                          |
| WORKDIR     | Sets working directory              |
| COPY        | Copies file into image              |
| RUN         | Executes command during build       |
| EXPOSE      | Documents container port            |
| CMD         | Default command when container runs |


**Task 3: CMD vs ENTRYPOINT**

Create an image with CMD ["echo", "hello"] — run it, then run it with a custom command. What happens?

<img width="882" height="22" alt="image" src="https://github.com/user-attachments/assets/5a6868d2-645f-45c1-ae0e-d71066c9f38a" />

<img width="1597" height="542" alt="image" src="https://github.com/user-attachments/assets/ad6b1158-2625-40a5-9154-b18548e6e36e" />


Create an image with ENTRYPOINT ["echo"] — run it, then run it with additional arguments. What happens?

<img width="1205" height="118" alt="image" src="https://github.com/user-attachments/assets/68d78ec0-be25-4b77-b4e9-c2c2a6d3f90c" />

<img width="1600" height="95" alt="image" src="https://github.com/user-attachments/assets/cd067ab5-66ae-480c-ba6b-8d7d38edb148" />

<img width="1584" height="440" alt="image" src="https://github.com/user-attachments/assets/bece20a8-dcb2-4b85-81e3-08685d4539a8" />


Write in your notes: When would you use CMD vs ENTRYPOINT?

| Use Case                                | CMD            | ENTRYPOINT |
| --------------------------------------- | -------------- | ---------- |
| Default command that users can override | ✅              | ❌          |
| Fixed executable container (like nginx) | ❌              | ✅          |
| Utility containers                      | ✅              | Sometimes  |
| Production apps                         | Often combined |            |


**Task 4: Build a Simple Web App Image**

Create a small static HTML file (index.html) with any content

Write a Dockerfile that:

Uses nginx:alpine as base

Copies your index.html to the Nginx web directory

Build and tag it my-website:v1

Run it with port mapping and access it in your browser

<img width="1426" height="614" alt="image" src="https://github.com/user-attachments/assets/83d660ec-9620-4ae3-b59d-20131829226f" />

<img width="1600" height="115" alt="image" src="https://github.com/user-attachments/assets/9dc647ab-ecf9-4490-96ac-edcd8503c766" />

<img width="1600" height="206" alt="image" src="https://github.com/user-attachments/assets/53e189c7-a7c1-45ac-b36f-5c2023eb2795" />



**Task 5: .dockerignore**

Create a .dockerignore file in one of your project folders

Add entries for: node_modules, .git, *.md, .env

Build the image — verify that ignored files are not included

<img width="1600" height="644" alt="image" src="https://github.com/user-attachments/assets/7c87ae17-2dd3-4226-bdc1-03d3024e4950" />


**Task 6: Build Optimization**

Build an image, then change one line and rebuild — notice how Docker uses cache

Reorder your Dockerfile so that frequently changing lines come last

Write in your notes: Why does layer order matter for build speed?

Docker builds images in layers.

Each instruction creates a new layer.

**Dockerfile**

FROM ubuntu:latest

RUN apt update

COPY . .

If you change a file → Docker rebuilds from COPY step onward.


Why Layer Order Matters?

Docker caches each step

If a layer changes → all next layers rebuild

Frequently changing code should be last

Rarely changing system installs should be first

This makes builds much faster.

**Bad Order (slow rebuild)**

Dockerfile

COPY . .

RUN apt update


**Good Order (fast rebuild)**

Dockerfile

FROM ubuntu:latest

RUN apt update && apt install -y curl

WORKDIR /app

COPY . .

CMD ["echo", "Optimized build"]


# Day 31 – Dockerfile

## What I Learned

- How to write Dockerfiles
- Difference between CMD and ENTRYPOINT
- How Docker layer caching works
- How to build and tag images
- How to serve static website using Nginx
- Importance of .dockerignore
- Why Dockerfile instruction order matters

## Key Commands

docker build -t image:tag .
docker run image
docker run -p 8080:80 image
































