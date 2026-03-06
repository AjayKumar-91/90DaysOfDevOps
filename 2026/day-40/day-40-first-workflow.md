# Day 40 – First GitHub Actions Workflow

## Repository
github-actions-practice

## Workflow File

.github/workflows/hello.yml

Task 1: Set Up

Create a new public GitHub repository called github-actions-practice

Clone it locally

Create the folder structure: .github/workflows/

<img width="1600" height="807" alt="image" src="https://github.com/user-attachments/assets/4f08f3fb-3bf3-4c01-b0b7-ac89b0bf6b68" />


Task 2: Hello Workflow

.github/workflows/hello.yml

Create .github/workflows/hello.yml with a workflow that:

name: Hello Workflow

on: push

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Say Hello
        run: echo "Hello from GitHub Actions!"
        

Triggers on every push

Has one job called greet

Runs on ubuntu-latest

Has two steps:

Step 1: Check out the code using actions/checkout

Step 2: Print Hello from GitHub Actions!

Push it. Go to the Actions tab on GitHub and watch it run.

Verify: Is it green? Click into the job and read every step.



Task 3: Understand the Anatomy

Look at your workflow file and write in your notes what each key does:

on:

jobs:

runs-on:

steps:

uses:

run:

name: (on a step)

## Workflow YAML

```yaml
name: Hello Workflow

on: push

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Print Hello
        run: echo "Hello from GitHub Actions!"

      - name: Print Date and Time
        run: date

      - name: Print Branch Name
        run: echo "Branch is ${{ github.ref_name }}"

      - name: List Files
        run: ls -la

      - name: Print Runner OS
        run: echo "Runner OS is $RUNNER_OS"


---

# What You Learned Today (Real DevOps Skill)

Today you used:

✅ **CI pipeline**  
✅ **GitHub Actions**  
✅ **Cloud runner**  
✅ **Workflow YAML**  
✅ **Pipeline debugging**

This is **core DevOps skill used in companies**.

---

If you want, I can also show you the **Day-41 task early** where we build a **Java CI pipeline (perfect for your Java background)**. It will look **very strong on your resume**.


        
