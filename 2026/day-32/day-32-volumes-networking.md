**Task 1: The Problem**

Run a Postgres or MySQL container

<img width="1600" height="417" alt="image" src="https://github.com/user-attachments/assets/9229d7a1-cec9-4a9e-a83e-6d681eb2e30e" />


Create some data inside it (a table, a few rows — anything)

<img width="1600" height="852" alt="image" src="https://github.com/user-attachments/assets/be3fdfd5-54e2-4a86-af72-cc76c2afe3cf" />


Stop and remove the container

<img width="1600" height="94" alt="image" src="https://github.com/user-attachments/assets/b2b13d79-2617-4e97-8509-17d7854299a1" />

Run a new one — is your data still there?

<img width="1600" height="473" alt="image" src="https://github.com/user-attachments/assets/81776b77-7fd1-414c-956d-38daa088a127" />


Write what happened and why.

Containers are temporary. Data stored inside the container filesystem is deleted when the container is removed.

MySQL stores data inside: /var/lib/mysql

Without a volume, this folder is destroyed when container is removed.


**Task 2: Named Volumes**

Create a named volume

Run the same database container, but this time attach the volume to it

Add some data, stop and remove the container

Run a brand new container with the same volume

Is the data still there?

Verify: docker volume ls, docker volume inspect


**Task 3: Bind Mounts**

Create a folder on your host machine with an index.html file

Run an Nginx container and bind mount your folder to the Nginx web directory

Access the page in your browser

Edit the index.html on your host — refresh the browser

Write in your notes: What is the difference between a named volume and a bind mount?


**Task 4: Docker Networking Basics**

List all Docker networks on your machine

Inspect the default bridge network

Run two containers on the default bridge — can they ping each other by name?

Run two containers on the default bridge — can they ping each other by IP?


**Task 5: Custom Networks**

Create a custom bridge network called my-app-net

Run two containers on my-app-net

Can they ping each other by name now?

Write in your notes: Why does custom networking allow name-based communication but the default bridge doesn't?


**Task 6: Put It Together**

Create a custom network

Run a database container (MySQL/Postgres) on that network with a volume for data

Run an app container (use any image) on the same network

Verify the app container can reach the database by container name










