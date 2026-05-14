# Day 04 – Linux Practice: Processes and Services

## System Information Check
```bash
uname -a
```
<img width="1917" height="137" alt="image" src="https://github.com/user-attachments/assets/4cdd87ea-cd57-4476-801a-8dcebff8f7d1" />

---

## Process Checks
```bash
ps -ef | head -n 10
```
<img width="1907" height="312" alt="image" src="https://github.com/user-attachments/assets/fa04d0ea-67e0-4a66-b6fa-b4abe4e2a3ce" />

---

## Find specific process
```bash
pgrep ssh
```
<img width="1911" height="91" alt="image" src="https://github.com/user-attachments/assets/e04b3f2f-0660-4002-8590-25f1227f4c0c" />

---

## Live process monitoring
```bash
top -b -n 1 | head -n 10
```
<img width="1917" height="281" alt="image" src="https://github.com/user-attachments/assets/04953232-da8e-4ea7-b153-e944bbfc4090" />

---

## Check SSH service status
```bash
systemctl status ssh
```
<img width="1917" height="452" alt="image" src="https://github.com/user-attachments/assets/95725185-c8ed-4ed3-ba4f-3476bbcd112c" />

---

## List running services
```bash
systemctl list-units --type=service | head -n 10
```
<img width="1917" height="300" alt="image" src="https://github.com/user-attachments/assets/fc7aba07-2d6b-4b41-b7ff-22177183bc8b" />

---

## SSH service logs
```bash
journalctl -u ssh --no-pager | tail -n 10
```
<img width="1917" height="292" alt="image" src="https://github.com/user-attachments/assets/71e7cd5a-2ab6-440e-ac27-9bfd7bc4abee" />

---

## System logs (general)
```bash
journalctl -u ssh -n 10 --no-pager
```
<img width="1917" height="367" alt="image" src="https://github.com/user-attachments/assets/d0ea9970-7214-4228-bbb1-7dd9838a0fd7" />
<img width="1917" height="912" alt="image" src="https://github.com/user-attachments/assets/c0d4043b-6933-4afb-8c5c-d9a457881712" />

---

## File log check
```bash
tail -n 10 /var/log/syslog
```
<img width="1917" height="431" alt="image" src="https://github.com/user-attachments/assets/a543b769-684b-4011-a7b8-d910ba055d73" />


