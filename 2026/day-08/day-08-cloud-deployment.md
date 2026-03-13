<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/df7547a7-42a2-4ee7-b927-1a9853dce503" />


<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/783618a9-8020-4d30-bba4-9a14fd34921b" />


<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/21559b48-bba8-46f0-bbfb-86a3600d8b72" />


<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/322aed2f-7db4-4307-bc44-35c1f4199317" />


<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/f6c6385c-9626-4ce7-b444-abe73d8695c2" />


<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/c584ca1d-070e-4617-b2c8-8dd520263631" />


<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/64313214-c879-49d1-b814-aa038a9a788f" />


<img width="1600" height="899" alt="image" src="https://github.com/user-attachments/assets/f092fb49-b162-4f83-8790-807a6ec3c1b5" />


<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/213ad990-9af8-43bb-9a61-4d3989a26bcc" />


<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/fdd94aff-5387-4678-80bf-70431adef4d9" />


<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/7d6f5631-1b33-4550-be0e-c438e482eb1d" />

<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/814759b8-bbd2-4851-b5ad-778405d784bb" />

# Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment

## Cloud Provider
AWS EC2

## Instance Details

Instance Type:
t2.micro

OS:
Ubuntu 22.04

---

# SSH Connection

Connected using:

ssh -i devops-key.pem ubuntu@<instance-ip>

Screenshot:
ssh-connection.png

---

# System Update

Commands used:

sudo apt update
sudo apt upgrade -y

---

# Docker Installation

Installed Docker using:

sudo apt install docker.io -y

Started Docker:

sudo systemctl start docker
sudo systemctl enable docker

Verified:

docker --version

---

# Nginx Installation

Installed using:

sudo apt install nginx -y

Started service:

sudo systemctl start nginx
sudo systemctl enable nginx

Verified status:

sudo systemctl status nginx

---

# Web Access Test

Accessed from browser:

http://<instance-ip>

Result:
Nginx welcome page displayed successfully.

Screenshot:
nginx-webpage.png

---

# Nginx Logs

Viewed logs:

sudo tail -n 20 /var/log/nginx/access.log

Saved logs to file:

sudo cp /var/log/nginx/access.log ~/nginx-logs.txt

Downloaded logs:

scp -i devops-key.pem ubuntu@<instance-ip>:~/nginx-logs.txt .

---

# Commands Used

ssh  
chmod  
apt update  
apt install docker.io  
apt install nginx  
systemctl  
tail  
scp  

---

# Challenges Faced

Initially port 80 was not accessible because HTTP was not enabled in the security group.

After enabling port 80, the Nginx webpage became accessible from the browser.

---

# What I Learned

• How to launch a cloud instance  
• How to connect to a server using SSH  
• Installing Docker and Nginx on a Linux server  
• Checking service status using systemctl  
• Accessing and exporting server logs

---

# Why This Matters for DevOps

These skills are essential for real production environments.

DevOps engineers frequently deploy applications on cloud servers, manage services remotely via SSH, configure firewalls/security groups, and monitor logs for debugging.

