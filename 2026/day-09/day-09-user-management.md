# Task 1: Create Users (20 minutes)

## Create three users with home directories and passwords:

tokyo

berlin

professor

Verify: Check /etc/passwd and /home/ directory

## Create users with home directories

sudo useradd -m tokyo

sudo useradd -m berlin

sudo useradd -m professor

## Set passwords for each user

sudo passwd tokyo

sudo passwd berlin

sudo passwd professor

## Verify users exist

cat /etc/passwd | grep -E 'tokyo|berlin|professor'

ls /home/

<img width="1600" height="899" alt="image" src="https://github.com/user-attachments/assets/f933d1cd-4506-48a3-9aea-035ceaa1dea6" />


# Task 2: Create Groups (10 minutes)

## Create two groups:

developers 

admins 

Verify: Check /etc/group

sudo groupadd developers

sudo groupadd admins

# Verify groups

cat /etc/group | grep -E 'developers|admins'


<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/76eb883b-ce67-4979-9570-e9ae0d4bb732" />


# Task 3: Assign to Groups (15 minutes)

Assign users:

tokyo → developers

berlin → developers + admins (both groups)

professor → admins

Verify: Use appropriate command to check group membership

## Assign users to groups

sudo usermod -aG developers tokyo

sudo usermod -aG developers,admins berlin

sudo usermod -aG admins professor

## Verify group membership

groups tokyo

groups berlin

groups professor


# Task 4: Shared Directory (20 minutes)

Create directory: /opt/dev-project

Set group owner to developers

Set permissions to 775 (rwxrwxr-x)

Test by creating files as tokyo and berlin

Verify: Check permissions and test file creation

## Create shared directory

sudo mkdir -p /opt/dev-project

## Set group owner

sudo chgrp developers /opt/dev-project

## Set permissions to 775 (rwxrwxr-x)

sudo chmod 775 /opt/dev-project

## Test file creation as tokyo

sudo -u tokyo touch /opt/dev-project/tokyo-file.txt

## Test file creation as berlin

sudo -u berlin touch /opt/dev-project/berlin-file.txt

## Verify permissions

ls -ld /opt/dev-project

ls -l /opt/dev-project


# Task 5: Team Workspace (20 minutes)

Create user nairobi with home directory

Create group project-team

Add nairobi and tokyo to project-team

Create /opt/team-workspace directory

Set group to project-team, permissions to 775

Test by creating file as nairobi

## Create user and group
sudo useradd -m nairobi
sudo groupadd project-team

## Add nairobi and tokyo to project-team
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo

## Create workspace directory
sudo mkdir -p /opt/team-workspace
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace

## Test file creation as nairobi
sudo -u nairobi touch /opt/team-workspace/nairobi-file.txt

## Verify permissions
ls -ld /opt/team-workspace
ls -l /opt/team-workspace


## Commands Used

useradd -m username

passwd username

groupadd groupname

usermod -aG group user

groups user

mkdir directory

chgrp group directory

chmod 775 directory

sudo -u user touch file
