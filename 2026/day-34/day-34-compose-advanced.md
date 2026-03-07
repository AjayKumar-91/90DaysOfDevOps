# Day 34 – Docker Compose: Real-World Multi-Container Apps

## Task 1: Build Your Own App Stack
- Web app: Java 8 simple CRUD connecting to MySQL
- Database: MySQL 8
- Cache: Redis

## Task 2: depends_on & Healthchecks
- `depends_on` with `condition: service_healthy` ensures web app waits for DB readiness
- DB healthcheck: `mysqladmin ping -h localhost`

## Task 3: Restart Policies
- `restart: always` restarts DB automatically
- `restart: on-failure` restarts only on failure
- Use `always` for critical services; `on-failure` for optional or debug

## Task 4: Custom Dockerfiles in Compose
- App builds from `Dockerfile`
- Code changes → rebuild with `docker compose up --build`

## Task 5: Named Networks & Volumes
- `app-network` ensures inter-service communication
- Named volume `db_data` persists MySQL data
- Labels added for better organization

## Task 6: Scaling (Bonus)
- Scaling web app to 3 replicas fails with port conflicts
- Requires a load balancer or proxy for multiple replicas
