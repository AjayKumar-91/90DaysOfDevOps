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

<img width="1380" height="162" alt="image" src="https://github.com/user-attachments/assets/2069ade9-3c43-4978-bc5b-fbc1b3e18d0a" />


Run the same database container, but this time attach the volume to it

<img width="1600" height="579" alt="image" src="https://github.com/user-attachments/assets/e31ca035-11c0-4ec6-af17-cc0ba6ff9a3c" />


Add some data, stop and remove the container

<img width="1376" height="152" alt="image" src="https://github.com/user-attachments/assets/0088b5da-228d-4948-8c7d-41db42aa2ecc" />


Run a brand new container with the same volume

<img width="1600" height="637" alt="image" src="https://github.com/user-attachments/assets/6c509e36-65ef-4d80-a45f-d2b8af40a3fd" />


Is the data still there?

Verify: docker volume ls, docker volume inspect

<img width="1570" height="313" alt="image" src="https://github.com/user-attachments/assets/a0e98ea6-57b8-4064-90fe-4e943e57c8bc" />



**Task 3: Bind Mounts**

Create a folder on your host machine with an index.html file

<img width="1600" height="141" alt="image" src="https://github.com/user-attachments/assets/e96728f3-06ea-4645-8f03-8e38e630ebb5" />


Run an Nginx container and bind mount your folder to the Nginx web directory

<img width="1600" height="256" alt="image" src="https://github.com/user-attachments/assets/ec446df6-96fb-42b6-9765-8b01e581564e" />


Access the page in your browser

<img width="1599" height="417" alt="image" src="https://github.com/user-attachments/assets/0a8414fa-6467-4db1-8bc3-1d40d85a9979" />

Edit the index.html on your host — refresh the browser

<img width="1600" height="272" alt="image" src="https://github.com/user-attachments/assets/2ce9910f-c7d5-48f0-954d-90e93fcfc3e0" />


Write in your notes: What is the difference between a named volume and a bind mount?


| Feature    | Named Volume   | Bind Mount  |
| ---------- | -------------- | ----------- |
| Managed by | Docker         | User        |
| Location   | Docker storage | Host folder |
| Best For   | Databases      | Development |
| Portable   | Yes            | No          |
| Live Edit  | No             | Yes         |





**Task 4: Docker Networking Basics**

List all Docker networks on your machine

<img width="1108" height="183" alt="image" src="https://github.com/user-attachments/assets/c0677d35-7bd7-477f-94b1-478bf9fa57c3" />


Inspect the default bridge network

<img width="1600" height="759" alt="image" src="https://github.com/user-attachments/assets/80dc7f07-697b-43a7-b1e8-de5c663f3760" />


Run two containers on the default bridge — can they ping each other by name?

<img width="1412" height="163" alt="image" src="https://github.com/user-attachments/assets/4726688c-3782-42df-8e13-a643209ed99d" />


Run two containers on the default bridge — can they ping each other by IP?

<img width="1600" height="521" alt="image" src="https://github.com/user-attachments/assets/88c47c2d-6f9a-4dc2-85a1-e501910ef078" />


<img width="1600" height="258" alt="image" src="https://github.com/user-attachments/assets/9530995a-5e31-46fc-bff1-e858739e4260" />



**Task 5: Custom Networks**

Create a custom bridge network called my-app-net

<img width="1159" height="63" alt="image" src="https://github.com/user-attachments/assets/5b35a617-cdc6-4b3d-b778-97a74a0afb1a" />


Run two containers on my-app-net

<img width="1318" height="273" alt="image" src="https://github.com/user-attachments/assets/02c4b0af-88a9-497d-8769-a9de7a087a22" />


Can they ping each other by name now?

<img width="1600" height="302" alt="image" src="https://github.com/user-attachments/assets/d074062b-0b34-439c-9b8a-659b94b4cb97" />


<img width="1600" height="358" alt="image" src="https://github.com/user-attachments/assets/c708266c-f070-40a6-9b15-3ba792aa2dcf" />


Write in your notes: Why does custom networking allow name-based communication but the default bridge doesn't?

Custom bridge networks:

Have built-in DNS

Support name-based communication

Better isolation

Recommended for microservices

Default bridge:

No automatic DNS resolution





**Task 6: Put It Together**

Create a custom network

<img width="1215" height="120" alt="image" src="https://github.com/user-attachments/assets/9241c38f-7718-42ed-ac25-0bd35fca9db3" />


Run a database container (MySQL/Postgres) on that network with a volume for data

<img width="1600" height="217" alt="image" src="https://github.com/user-attachments/assets/e7a10a59-4cdb-4015-b693-af1d83d4f540" />


Run an app container (use any image) on the same network

<img width="1600" height="199" alt="image" src="https://github.com/user-attachments/assets/881a9032-1a51-407e-a92d-a8f8da5bafbe" />




Verify the app container can reach the database by container name

<img width="1366" height="248" alt="image" src="https://github.com/user-attachments/assets/9862d16c-73e2-459e-8375-74ae44e37001" />


<img width="1600" height="760" alt="image" src="https://github.com/user-attachments/assets/e94bf720-c79f-45e0-85f7-d33ac2b58e36" />


<img width="1600" height="513" alt="image" src="https://github.com/user-attachments/assets/2994dee3-bf5a-489b-bdd7-65bcb01ea3e8" />

<img width="1010" height="255" alt="image" src="https://github.com/user-attachments/assets/ddc06cf8-1c03-4e3e-99b1-c34b3ea120f3" />


Final Notes for Your Markdown File

Write:

What happened without volume? → Data lost

What happened with volume? → Data persisted

Difference between volume & bind mount

Default bridge vs custom bridge

Why custom networks are production ready










