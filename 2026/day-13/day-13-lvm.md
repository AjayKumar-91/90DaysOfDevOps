Day 13 – Linux Volume Management (LVM)

<img width="1600" height="708" alt="image" src="https://github.com/user-attachments/assets/f3dea853-82cd-4e5b-a14f-7817a2c41e36" />

Task

Learn LVM to manage storage flexibly – create, extend, and mount volumes.

<img width="1600" height="703" alt="image" src="https://github.com/user-attachments/assets/65bb9849-b81d-4ea1-b6e9-b8a114273cd3" />

<img width="1600" height="704" alt="image" src="https://github.com/user-attachments/assets/db2f6361-3b36-4cba-84bb-b410d60b7e2d" />

<img width="1600" height="703" alt="image" src="https://github.com/user-attachments/assets/5952e77e-94c0-453e-a6a3-866e5513e246" />

<img width="1600" height="704" alt="image" src="https://github.com/user-attachments/assets/b5e46adb-cc65-466c-8bf0-d3169a1ac520" />

<img width="1600" height="737" alt="image" src="https://github.com/user-attachments/assets/6f6ee9f2-8389-4d8b-97a8-da569816fe19" />

<img width="1600" height="708" alt="image" src="https://github.com/user-attachments/assets/f85ccc6e-f466-42a6-b98e-66572aea2530" />

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
Challenge Tasks
Task 1: Check Current Storage
Run: lsblk, pvs, vgs, lvs, df -h

Task 2: Create Physical Volume
pvcreate /dev/sdb   # or your loop device
pvs
Task 3: Create Volume Group
vgcreate devops-vg /dev/sdb
vgs
Task 4: Create Logical Volume
lvcreate -L 500M -n app-data devops-vg
lvs
Task 5: Format and Mount
mkfs.ext4 /dev/devops-vg/app-data
mkdir -p /mnt/app-data
mount /dev/devops-vg/app-data /mnt/app-data
df -h /mnt/app-data
Task 6: Extend the Volume
lvextend -L +200M /dev/devops-vg/app-data
resize2fs /dev/devops-vg/app-data
df -h /mnt/app-data
Documentation
Create day-13-lvm.md with:


What you learned (3 points)

What I Learned

LVM allows dynamic disk management without repartitioning.

Logical Volumes can be extended without downtime.

LVM separates physical storage from logical filesystem structure.
