# Linux Troubleshooting Runbook

# 1. Environment Basics

## Check Kernel Information

Command:
uname -a 

<img width="1582" height="438" alt="image" src="https://github.com/user-attachments/assets/0b3abf19-ea56-4fc9-b570-0b54f03e9bb2" />



# 2. Filesystem Sanity Check

## Create Test Folder


<img width="1093" height="88" alt="image" src="https://github.com/user-attachments/assets/bf030f1c-7756-432b-8b24-4b52928c3655" />



# 3. CPU & Memory Snapshot

## View Running Processes - ps -ef | grep ssh

### CPU / Memory : Create temp folder and file


<img width="1600" height="474" alt="image" src="https://github.com/user-attachments/assets/abe4a4ef-a441-4237-9f1e-3e775f0a3ff1" />


<img width="1600" height="833" alt="image" src="https://github.com/user-attachments/assets/b9e622e2-2a0c-4482-a5fd-dc8288c371cb" />


<img width="1578" height="563" alt="image" src="https://github.com/user-attachments/assets/039b84bb-949c-44a3-aa2f-26b570e0e4fd" />


## Memory Usage

## Disk / IO : free -h

<img width="607" height="70" alt="image" src="https://github.com/user-attachments/assets/57b48650-f4d8-48b1-8d70-658494041360" />


<img width="651" height="67" alt="image" src="https://github.com/user-attachments/assets/2792ff0b-5856-4fc2-90b7-1e5412dfe764" />


<img width="861" height="188" alt="image" src="https://github.com/user-attachments/assets/6bab746f-59ed-449b-9e01-41b6a41e4b9f" />



# 5. Network Snapshot

## Check Listening Ports

## Network : Command:  ss -tulpn | grep ssh


<img width="1582" height="190" alt="image" src="https://github.com/user-attachments/assets/eca346cf-2f85-47d7-bb64-a23f6f6a7412" />


<img width="1600" height="224" alt="image" src="https://github.com/user-attachments/assets/969fc618-8d40-4aba-9d41-c2a5ffa285fc" />


curl -I <service-endpoint>/ping I do not understand, please help me


# 6. Logs Reviewed

## Check SSH Logs,  Command:- journalctl -u ssh -n 50


<img width="1338" height="227" alt="image" src="https://github.com/user-attachments/assets/8e5bd5f0-a078-4711-b343-f0197e3e6fdd" />


<img width="1600" height="405" alt="image" src="https://github.com/user-attachments/assets/5fa61138-a688-4d60-9192-43ff85aa83db" />






