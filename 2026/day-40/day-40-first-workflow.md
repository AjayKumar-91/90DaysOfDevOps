# Day 40 – First GitHub Actions Workflow

## Repository
github-actions-practice

## Workflow File

.github/workflows/hello.yml

### Task 1: Set Up
1. Create a new **public** GitHub repository called `github-actions-practice`
2. Clone it locally
3. Create the folder structure: `.github/workflows/`
<img width="1917" height="947" alt="image" src="https://github.com/user-attachments/assets/c305173f-c77e-4462-a261-6f62066b8917" />
<img width="1482" height="392" alt="image" src="https://github.com/user-attachments/assets/9d72d3b9-6be1-4392-a378-977054c9fa6c" />


<img width="1600" height="807" alt="image" src="https://github.com/user-attachments/assets/4f08f3fb-3bf3-4c01-b0b7-ac89b0bf6b68" />

---


## Task 2: Hello Workflow
Create `.github/workflows/hello.yml` with a workflow that:
1. Triggers on every `push`
2. Has one job called `greet`
3. Runs on `ubuntu-latest`
4. Has two steps:
   - Step 1: Check out the code using `actions/checkout`
   - Step 2: Print `Hello from GitHub Actions!`

Push it. Go to the **Actions** tab on GitHub and watch it run.

**Verify:** Is it green? Click into the job and read every step.

# Task 2: Hello Workflow

Create file:

```bash
.github/workflows/hello.yml
```

Add this workflow:

```yaml
name: Hello Workflow

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Print Welcome Message
        run: echo "Hello from GitHub Actions!"
```

Push code:

```bash
git add .
git commit -m "Added hello workflow"
git push origin main
```

Go to GitHub → Actions tab and verify workflow is green.

---
<img width="1600" height="723" alt="image" src="https://github.com/user-attachments/assets/114d0f02-3355-4467-b53a-258cc529c770" />
<img width="1482" height="217" alt="image" src="https://github.com/user-attachments/assets/f6428f78-6f02-411c-aaec-bcf896a4b6c1" />
<img width="1917" height="791" alt="image" src="https://github.com/user-attachments/assets/a62e09b1-27f2-417a-8e4e-dcdf95a1c4aa" />
<img width="1917" height="911" alt="image" src="https://github.com/user-attachments/assets/cb227b09-cbae-4475-8bce-837af50c9713" />
<img width="1906" height="907" alt="image" src="https://github.com/user-attachments/assets/8eb6436e-2679-49a7-95e7-5ee445896be4" />
<img width="1917" height="922" alt="image" src="https://github.com/user-attachments/assets/911957ee-afeb-470a-bcc9-91095592784c" />


Push it. Go to the Actions tab on GitHub and watch it run.

Verify: Is it green? Click into the job and read every step.



# Task 3: Workflow Anatomy

## `on:`
Defines when workflow runs.

Example:

```yaml
on:
  push:
```

---

## `jobs:`
Contains all jobs.

Example:

```yaml
jobs:
```

---

## `runs-on:`
Defines operating system runner.

Example:

```yaml
runs-on: ubuntu-latest
```

---

## `steps:`
List of commands/actions executed one by one.

Example:

```yaml
steps:
```

---

## `uses:`
Uses prebuilt GitHub Actions.

Example:

```yaml
uses: actions/checkout@v4
```

---

## `run:`
Executes shell command.

Example:

```yaml
run: echo "Hello"
```

---

## `name:`
Readable name visible in Actions UI.

Example:

```yaml
- name: Print Message
```

---

# Task 4: Add More Steps

Update workflow:

```yaml
name: Hello Workflow

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Print Welcome Message
        run: echo "Hello from GitHub Actions!"

      - name: Print Current Date and Time
        run: date

      - name: Print Branch Name
        run: echo "Branch Name: ${{ github.ref_name }}"

      - name: List Repository Files
        run: ls -la

      - name: Print Runner OS
        run: echo "Runner OS: $RUNNER_OS"
```

Push again:

```bash
git add .
git commit -m "Added extra workflow steps"
git push origin main
```

---
# Task 5: Break Pipeline Intentionally

Add failing step:

```yaml
- name: Fail Pipeline
  run: exit 1
```

Example:

```yaml
name: Hello Workflow

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Print Message
        run: echo "Hello from GitHub Actions!"

      - name: Fail Pipeline
        run: exit 1
```

Push changes and observe failed workflow in Actions tab.

---

# Understanding Failed Pipeline

Failed pipeline shows:

```bash
Error: Process completed with exit code 1.
```

How to debug:

1. Open Actions tab
2. Click failed workflow
3. Open failed job
4. Expand failed step
5. Read logs carefully

---

# Fix Pipeline

Replace failing step:

```yaml
- name: Success Step
  run: echo "Pipeline fixed!"
```

Push again.

---

# What You Learned

- GitHub Actions basics
- Workflow structure
- Jobs and steps
- GitHub runners
- CI/CD basics
- Debugging failed workflows
- GitHub variables
- YAML workflow syntax

---

# Next Practice Ideas

- Multiple jobs
- Matrix builds
- Docker workflows
- Kubernetes deployment
- GitHub Secrets
- Environment variables
- DevSecOps pipelines
