# Docker Cheat Sheet

A quick reference for commonly used Docker commands.

---

# 1. Container Commands

Run a container (interactive mode)

docker run -it ubuntu bash

Run container in background (detached)

docker run -d nginx

List running containers

docker ps

List all containers

docker ps -a

Stop container

docker stop <container_id>

Remove container

docker rm <container_id>

Execute command inside running container

docker exec -it <container_id> bash

View container logs

docker logs <container_id>

---

# 2. Image Commands

Pull image from Docker Hub

docker pull nginx

List images

docker images

Build image from Dockerfile

docker build -t my-image .

Tag image

docker tag my-image username/my-image:latest

Push image to Docker Hub

docker push username/my-image:latest

Remove image

docker rmi <image_id>

---

# 3. Volume Commands

Create volume

docker volume create myvolume

List volumes

docker volume ls

Inspect volume

docker volume inspect myvolume

Remove volume

docker volume rm myvolume

Run container with volume

docker run -v myvolume:/data nginx

---

# 4. Bind Mounts

Mount local folder to container

docker run -v $(pwd):/app nginx

---

# 5. Network Commands

List networks

docker network ls

Create custom network

docker network create mynetwork

Inspect network

docker network inspect mynetwork

Connect container to network

docker network connect mynetwork <container>

---

# 6. Docker Compose Commands

Start services

docker compose up

Run in background

docker compose up -d

Stop services

docker compose down

View running services

docker compose ps

View logs

docker compose logs

Build services

docker compose build

---

# 7. Cleanup Commands

Remove unused containers/images

docker system prune

Check Docker disk usage

docker system df

---

# 8. Dockerfile Instructions

FROM → Base image

RUN → Execute command during build

COPY → Copy files from host to container

WORKDIR → Set working directory

EXPOSE → Document port used

CMD → Default command when container starts

ENTRYPOINT → Main command that always runs

---

# 9. Port Mapping

-p 8080:80

8080 = host port  
80 = container port

Access container service at:

http://localhost:8080
