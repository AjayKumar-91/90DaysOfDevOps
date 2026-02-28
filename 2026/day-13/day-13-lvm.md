Day 13 – Linux Volume Management (LVM)

Task

Learn LVM to manage storage flexibly – create, extend, and mount volumes.

<img width="1600" height="703" alt="image" src="https://github.com/user-attachments/assets/65bb9849-b81d-4ea1-b6e9-b8a114273cd3" />

<img width="1600" height="704" alt="image" src="https://github.com/user-attachments/assets/db2f6361-3b36-4cba-84bb-b410d60b7e2d" />

<img width="1600" height="703" alt="image" src="https://github.com/user-attachments/assets/5952e77e-94c0-453e-a6a3-866e5513e246" />

<img width="1600" height="704" alt="image" src="https://github.com/user-attachments/assets/b5e46adb-cc65-466c-8bf0-d3169a1ac520" />

<img width="1600" height="737" alt="image" src="https://github.com/user-attachments/assets/6f6ee9f2-8389-4d8b-97a8-da569816fe19" />

<img width="1600" height="708" alt="image" src="https://github.com/user-attachments/assets/f85ccc6e-f466-42a6-b98e-66572aea2530" />

<img width="1600" height="703" alt="image" src="https://github.com/user-attachments/assets/832b68c3-4b00-4b69-a2ae-e6144397499b" />

<img width="1600" height="707" alt="image" src="https://github.com/user-attachments/assets/624753ab-aadd-45d8-b55b-4528559744ef" />

created volume inside EC2

<img width="1600" height="651" alt="image" src="https://github.com/user-attachments/assets/a90a4358-7ef8-441e-8fd7-63a67484aa56" />

<img width="1600" height="703" alt="image" src="https://github.com/user-attachments/assets/e649aace-d791-48b6-9796-1f8dd3c97f05" />

I attach a volume with my EC2 server

<img width="1600" height="706" alt="image" src="https://github.com/user-attachments/assets/53d8351a-2b3e-4d3c-8bb5-c1847a0040da" />

<img width="1600" height="707" alt="image" src="https://github.com/user-attachments/assets/85d1a52c-ef3c-4c36-a9e3-d61ece02665f" />

<img width="977" height="495" alt="image" src="https://github.com/user-attachments/assets/6fb13e72-268b-49f3-90a7-4fadf060f167" />



A markdown file: day-13-lvm.md

Screenshots of command outputs

Before You Start

Switch to root user:

sudo -i

or

sudo su

No spare disk? Create a virtual one (watch the tutorial):

dd if=/dev/zero of=/tmp/disk1.img bs=1M count=1024

losetup -fP /tmp/disk1.img

losetup -a   # Note the device name (e.g., /dev/loop0)


Task 1: Check Current Storage

Run: lsblk, pvs, vgs, lvs, df -h

<img width="802" height="487" alt="image" src="https://github.com/user-attachments/assets/4977af4e-1c32-464a-8139-bd002bbbeeaa" />


Task 2: Create Physical Volume

pvcreate /dev/sdb   # or your loop device

pvs

Task 3: Create Volume Group

vgcreate devops-vg /dev/sdb

vgs

Task 4: Create Logical Volume

lvcreate -L 500M -n app-data devops-vg

lvs

<img width="1600" height="613" alt="image" src="https://github.com/user-attachments/assets/2f6cbd8f-9df2-43e2-bba3-2b76a3322ba3" />


Task 5: Format and Mount

mkfs.ext4 /dev/devops-vg/app-data

mkdir -p /mnt/app-data

mount /dev/devops-vg/app-data /mnt/app-data

df -h /mnt/app-data

<img width="1599" height="470" alt="image" src="https://github.com/user-attachments/assets/452ee030-5856-4984-a133-cab880d16f75" />


Task 6: Extend the Volume

lvextend -L +200M /dev/devops-vg/app-data

resize2fs /dev/devops-vg/app-data

df -h /mnt/app-data

<img width="1444" height="451" alt="image" src="https://github.com/user-attachments/assets/65d884b9-5bca-4141-8c11-5cffd24adb42" />


Documentation

Create day-13-lvm.md with:


What you learned (3 points)

What I Learned

LVM allows dynamic disk management without repartitioning.

Logical Volumes can be extended without downtime.

LVM separates physical storage from logical filesystem structure.
