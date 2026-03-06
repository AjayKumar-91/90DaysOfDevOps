# Day 40 – First GitHub Actions Workflow

## Repository
github-actions-practice

## Workflow File

.github/workflows/hello.yml

## Task 1: Set Up

Create a new public GitHub repository called github-actions-practice

Clone it locally

Create the folder structure: .github/workflows/

<img width="1600" height="807" alt="image" src="https://github.com/user-attachments/assets/4f08f3fb-3bf3-4c01-b0b7-ac89b0bf6b68" />


## Task 2: Hello Workflow

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

<img width="1600" height="723" alt="image" src="https://github.com/user-attachments/assets/114d0f02-3355-4467-b53a-258cc529c770" />


Push it. Go to the Actions tab on GitHub and watch it run.

Verify: Is it green? Click into the job and read every step.



## Task 3: Understand the Anatomy

Look at your workflow file and write in your notes what each key does:

on: Defines when the workflow should run.

on: push

Means workflow runs every time code is pushed to the repository.

jobs: Defines tasks executed in the workflow. # these are jobs inside the workflow

jobs:
  greet: # this is the name of the job

A workflow can have multiple jobs.

runs-on: Defines the virtual machine (runner) used.

Example:

# this is github runner, each job runs on a runner

runs-on: ubuntu-latest 

GitHub provides a Linux environment to run the job.

steps: Defines individual commands executed inside a job.

Example:

steps: 

Each step runs sequentially.

uses: Used to run prebuilt GitHub Actions.

Example:

uses: actions/checkout@v4

This action downloads your repo code to the runner.

run: Runs shell commands on the runner.

Example:

run: echo "Hello"


name: (on a step) Adds a readable label for a step in the UI.

Example:

name: Checkout Repository


## Task 4: Add More Steps

Update hello.yml to also:

Print the current date and time

Print the name of the branch that triggered the run (hint: GitHub provides this as a variable)

List the files in the repo

Print the runner's operating system

Push again — watch the new run.

Updated hello.yml




## Task 5: Break It On Purpose 

Add a step that runs a command that will fail (e.g., exit 1 or a misspelled command)

Push and observe what happens in the Actions tab

Fix it and push again

Write in your notes: What does a failed pipeline look like? How do you read the error?

<img width="1600" height="857" alt="image" src="https://github.com/user-attachments/assets/e6e5502d-5c7d-4b4b-bf77-5f9fd85ea560" />

<img width="1600" height="857" alt="image" src="https://github.com/user-attachments/assets/2dae17dc-213b-4255-95fd-8bf03519a18a" />

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


        
