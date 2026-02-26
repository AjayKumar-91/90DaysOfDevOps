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



**Task 3: Two-Container Setup**

Write a docker-compose.yml that runs:

A WordPress container

A MySQL container

They should:

Be on the same network (Compose does this automatically)

MySQL should have a named volume for data persistence

WordPress should connect to MySQL using the service name

Start it, access WordPress in your browser, and set it up.

docker compose up -d

http://localhost:8090

<img width="1600" height="778" alt="image" src="https://github.com/user-attachments/assets/9a1ac1e7-da32-4950-bccc-77c8d6805b86" />

Verify: Stop and restart with docker compose down and docker compose up — is your WordPress data still there?

docker compose down

docker compose up -d

MySQL uses named volume mysql_data

Compose preserves volumes unless removed explicitly

<img width="1600" height="826" alt="image" src="https://github.com/user-attachments/assets/e09648dd-2590-41ab-9ab2-d6927ee82269" />

<img width="1600" height="799" alt="image" src="https://github.com/user-attachments/assets/9f7d669b-a008-460f-8dc4-9c257943e5d5" />


**Task 4: Compose Commands**

Practice and document these:

Start services in detached mode

**docker compose up -d**
<img width="1259" height="85" alt="image" src="https://github.com/user-attachments/assets/0d0fe2b0-d051-4a77-b824-df7d4bce9921" />


View running services

**docker compose ps**
<img width="1444" height="75" alt="image" src="https://github.com/user-attachments/assets/04f813e2-c524-4eb7-98be-e9fe6c4958aa" />


View logs of all services

**docker compose logs -f**
<img width="1600" height="779" alt="image" src="https://github.com/user-attachments/assets/b6f865bc-7e63-44cb-b82a-2ea186979815" />


View logs of a specific service

**docker compose logs -f wordpress**
<img width="1600" height="771" alt="image" src="https://github.com/user-attachments/assets/c54133f5-88a3-4cab-9847-3e2e70d759bb" />


Stop services without removing

**docker compose stop**
<img width="1233" height="103" alt="image" src="https://github.com/user-attachments/assets/53c991cc-764c-4b01-8249-c35021498809" />


Remove everything (containers, networks)

**docker compose down**
<img width="1019" height="145" alt="image" src="https://github.com/user-attachments/assets/4a59511a-e8ef-439b-bc58-b833fbd212f8" />


Rebuild images if you make a change

**docker compose up -d --build**
<img width="1139" height="171" alt="image" src="https://github.com/user-attachments/assets/c28ae729-949a-4f94-a00b-596d22eecb5f" />




**Task 5: Environment Variables**

Add environment variables directly in your docker-compose.yml

<img width="1372" height="622" alt="image" src="https://github.com/user-attachments/assets/8e23c550-b424-4c65-a3ae-eec12a35c0d9" />


Create a .env file and reference variables from it in your compose file

<img width="1158" height="292" alt="image" src="https://github.com/user-attachments/assets/069fc33e-e0ad-47bd-85f7-aedb8da546d3" />


Verify the variables are being picked up
<img width="1501" height="774" alt="image" src="https://github.com/user-attachments/assets/6f9f2e72-f0a0-48da-bbcb-75963077b5dd" />

**What You Learned Today**

 Compose manages multiple containers

 Compose creates networks automatically

 Service names work as DNS

 Named volumes persist data

 .env makes configs cleaner

 One command starts full application

















