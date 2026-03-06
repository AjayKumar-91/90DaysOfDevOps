# Day 37 – Docker Revision

Goal: Review everything learned from Day 29–36.

---

# Self-Assessment Checklist

| Skill | Status |
|-----|-----|
Run container from Docker Hub | ✔ Can Do |
List, stop, remove containers | ✔ Can Do |
Explain image layers | ✔ Can Do |
Write Dockerfile | ✔ Can Do |
CMD vs ENTRYPOINT | ✔ Can Do |
Build custom image | ✔ Can Do |
Use volumes | ✔ Can Do |
Use bind mounts | ✔ Can Do |
Create networks | ✔ Can Do |
Docker Compose multi-container | ✔ Can Do |
Use .env variables | ⚠ Slightly Shaky |
Multi-stage builds | ⚠ Slightly Shaky |
Push image to Docker Hub | ✔ Can Do |
Healthchecks & depends_on | ⚠ Need practice |

---

# Quick-Fire Questions

## 1. Difference between Image and Container

Image  
A read-only template used to create containers.

Container  
A running instance of an image.

Example

Image → nginx  
Container → running nginx server

---

## 2. What happens to data when container is removed?

Data inside the container filesystem is **deleted** when the container is removed.

To persist data we use:

Volumes  
Bind mounts

---

## 3. How containers communicate on same network?

Containers on the same custom network communicate using **container name as hostname**.

Example

backend → database


DB_HOST=database

Docker DNS resolves it automatically.

---

## 4. Difference between

docker compose down

and

docker compose down -v

docker compose down

Stops and removes containers and networks.

docker compose down -v

Also removes **volumes (data deleted)**.

---

## 5. Why multi-stage builds are useful?

Multi-stage builds reduce image size.

Example:

Stage 1 → build application  
Stage 2 → copy only final files

Result:

Small image  
More secure  
Faster deployment

---

## 6. Difference between COPY and ADD

COPY

Copies files from host to container.

ADD

Same as COPY but also supports:

URL downloads  
Auto extract tar files

Best practice: **Use COPY unless ADD is required.**

---

## 7. What does -p 8080:80 mean?

Port mapping.

Host port → Container port

8080 → Host  
80 → Container

Access service via:

http://localhost:8080

---

## 8. Check Docker disk usage

docker system df

Shows space used by:

Images  
Containers  
Volumes  
Build cache

---

# Weak Areas to Revisit

1️⃣ Multi-stage Dockerfiles  
2️⃣ Docker Compose environment variables

Plan: redo hands-on tasks for these topics.

---

# Conclusion

Day 37 helped reinforce Docker fundamentals and identify weak areas before moving to advanced container orchestration topics.
