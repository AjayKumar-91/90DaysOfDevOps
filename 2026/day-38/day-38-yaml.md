# Day 38 – YAML Basics

## Challenge Tasks

### Task 1: Key-Value Pairs
Create `person.yaml` that describes yourself with:
- `name`
- `role`
- `experience_years`
- `learning` (a boolean)

**Verify:** Run `cat person.yaml` — does it look clean? No tabs?
<img width="1596" height="597" alt="image" src="https://github.com/user-attachments/assets/483d9faa-bc0d-49fe-ad14-a0e0fca9e351" />

```
name: Ajay Kumar
role: Devops Engineer

experience_years:
  total_it: 7+
  java: 4+
  java_support: 3+
  spring_boot: 2+
  linux: 2+
  shell_script: 2+
  docker: 1+
  github: 2+
  network: 1+

learning: true
```

---

### Task 2: Lists
Add to `person.yaml`:
- `tools` — a list of 5 DevOps tools you know or are learning
- `hobbies` — a list using the inline format `[item1, item2]`

Write in your notes: What are the two ways to write a list in YAML?

```
tools:
  - Docker
  - Github
  - Linux
  - Jenkins
  - Kibana
  - Kubernetes

hobbies: [learning-devops, cricket, carrom]
```

---


### Task 3: Nested Objects
Create `server.yaml` that describes a server:
- `server` with nested keys: `name`, `ip`, `port`
- `database` with nested keys: `host`, `name`, `credentials` (nested further: `user`, `password`)

Nested Objects
YAML supports hierarchy using indentation
Useful for representing structured data like server configs

**Verify:** Try adding a tab instead of spaces — what happens when you validate it?

```
server:
  name: web-server
  ip: 192.168.1.10
  port: 8080

database:
  host: db-server
  name: devops_db
  credentials:
    user: admin
    password: admin123
```

---

### Task 4: Multi-line Strings
In `server.yaml`, add a `startup_script` field using:
1. The `|` block style (preserves newlines)
2. The `>` fold style (folds into one line)

Write in your notes: When would you use `|` vs `>`?

Multi-line Strings
| (Pipe)
Preserves new lines exactly as written
Used for scripts, logs
> (Fold)
Converts multi-line into a single line
Used for long text paragraphs

+ The | block style (preserves newlines)
```
startup_script_block: |
  #!/bin/bash
  echo "Starting server..."
  docker start nginx
  echo "Server started"
```
### it became :
```YAML
#!/bin/bash
echo "Starting server..."
docker start nginx
echo "Server started"
```

+ The > fold style (folds into one line)
```
startup_script_fold: >
  #!/bin/bash
  echo "Starting server..."
  docker start nginx
  echo "Server started"
```
### it became :
```YAML
#!/bin/bash echo "Starting server..." server system is starting echo "My server is up and running"
```

---


### Task 5: Validate Your YAML
1. Install `yamllint` or use an online validator
2. Validate both your YAML files
3. Intentionally break the indentation — what error do you get?
4. Fix it and validate again

Install yamllint
```
sudo apt update
sudo apt install yamllint -y
pip install yamllint
yamllint person.yaml
yamllint server.yaml
```
<img width="895" height="112" alt="image" src="https://github.com/user-attachments/assets/74835b05-cd9e-468d-a983-b5f389471351" />

<img width="1012" height="647" alt="image" src="https://github.com/user-attachments/assets/9a7e48d7-b6aa-4fff-83ce-841ffb69431c" />
<img width="1007" height="627" alt="image" src="https://github.com/user-attachments/assets/85286db2-37a6-4ffa-bb58-660707c79520" />


---

### Task 6: Spot the Difference
Read both blocks and write what's wrong with the second one:

```yaml
# Block 1 - correct
name: devops
tools:
  - docker
  - kubernetes
```

```yaml
# Block 2 - broken
name: devops
tools:
- docker
  - kubernetes
```

---



### Block Style

