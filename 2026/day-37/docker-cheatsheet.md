# Docker Cheat Sheet

## Container Commands
docker run nginx              # Run container
docker run -d nginx           # Run in detached mode
docker ps                     # List running containers
docker ps -a                  # List all containers
docker stop <container>       # Stop container
docker rm <container>         # Remove container
docker exec -it <container> bash  # Enter container
docker logs <container>       # View container logs

## Image Commands
docker build -t myimage .     # Build image
docker images                 # List images
docker pull nginx             # Pull image from Docker Hub
docker push username/image    # Push image to Docker Hub
docker tag image newname      # Tag image
docker rmi image              # Remove image

## Volume Commands
docker volume create myvol    # Create volume
docker volume ls              # List volumes
docker volume inspect myvol   # Inspect volume
docker volume rm myvol        # Remove volume

## Network Commands
docker network create mynet   # Create network
docker network ls             # List networks
docker network inspect mynet  # Inspect network
docker network connect mynet container

## Docker Compose Commands
docker compose up             # Start services
docker compose up -d          # Start in background
docker compose down           # Stop services
docker compose ps             # List services
docker compose logs           # View logs
docker compose build          # Build images

## Cleanup Commands
docker system prune           # Remove unused resources
docker container prune        # Remove stopped containers
docker image prune            # Remove unused images
docker system df              # Show Docker disk usage

## Dockerfile Instructions
FROM        # Base image
RUN         # Execute command
COPY        # Copy files
WORKDIR     # Set working directory
EXPOSE      # Expose port
CMD         # Default command
ENTRYPOINT  # Main container command
