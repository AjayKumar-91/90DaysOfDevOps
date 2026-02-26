**Task 1: Install & Verify**

Check if Docker Compose is available on your machine

Verify the version

<img width="1128" height="119" alt="image" src="https://github.com/user-attachments/assets/426607d8-8a15-4038-ba79-f94afca361e1" />


**Task 2: Your First Compose File**

Create a folder compose-basics

<img width="1492" height="291" alt="image" src="https://github.com/user-attachments/assets/ccf9d6be-5988-4557-831d-fb1c2ee8b48f" />

Write a docker-compose.yml that runs a single Nginx container with port mapping

<img width="716" height="239" alt="image" src="https://github.com/user-attachments/assets/c9d7f2c1-5a7c-4318-84a4-43750b114292" />

Start it with docker compose up

<img width="1597" height="207" alt="image" src="https://github.com/user-attachments/assets/433ae127-daef-45e5-9ea0-b584b5a7e26a" />


Access it in your browser

<img width="1600" height="357" alt="image" src="https://github.com/user-attachments/assets/88081fc8-a914-4577-9fde-83bcb5a64cc1" />


Stop it with docker compose down

<img width="1600" height="231" alt="image" src="https://github.com/user-attachments/assets/b725b0b9-1705-40ef-b08b-55c39dd1bb2c" />



Task 3: Two-Container Setup

Write a docker-compose.yml that runs:


A WordPress container

A MySQL container

They should:

Be on the same network (Compose does this automatically)

MySQL should have a named volume for data persistence

WordPress should connect to MySQL using the service name

Start it, access WordPress in your browser, and set it up.

Verify: Stop and restart with docker compose down and docker compose up — is your WordPress data still there?

















