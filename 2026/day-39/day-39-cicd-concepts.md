# Day 39 – What is CI/CD?

## Challenge Tasks

### Task 1: The Problem
Think about a team of 5 developers all pushing code to the same repo manually deploying to production.

Write in your notes:
1. What can go wrong?
2. What does "it works on my machine" mean and why is it a real problem?
3. How many times a day can a team safely deploy manually?
# Task 1: The Problem

## Scenario
A team of 5 developers is working on the same project and manually deploying code to production.

---

## 1. What can go wrong?

When multiple developers manually deploy code, several problems can happen:

- Code conflicts between developers
- One developer may overwrite another person's changes
- Bugs may directly reach production
- Deployment steps may be forgotten or done incorrectly
- Different environments may behave differently
- Rollbacks become difficult if deployment fails
- Downtime can happen during deployment
- Human errors increase as deployments become more frequent

---

## 2. What does "It works on my machine" mean?

"It works on my machine" means:

> The application runs correctly on the developer’s local computer but fails on another machine or server.

### Why this happens

- Different operating systems
- Different software versions
- Missing dependencies
- Different environment variables
- Configuration mismatch

### Why it is a real problem

This creates inconsistency between development, testing, and production environments.

As a result:
- Bugs appear after deployment
- Teams waste time debugging environment issues
- Production systems become unstable

CI/CD helps solve this by creating consistent automated environments.

---

## 3. How many times a day can a team safely deploy manually?

Manual deployments are slow and risky.

A team can usually safely deploy:
- **1 to 2 times per day**

More frequent manual deployments increase:
- Human mistakes
- Deployment failures
- Stress on developers
- Production downtime

CI/CD automation allows teams to deploy many times per day safely and reliably.

---

## Key Takeaway

Manual deployment does not scale well for modern software teams.

CI/CD improves:
- Speed
- Reliability
- Automation
- Code quality
- Deployment safety
---

### Task 2: CI vs CD
Research and write short definitions (2-3 lines each):
1. **Continuous Integration** — what happens, how often, what it catches
2. **Continuous Delivery** — how it's different from CI, what "delivery" means
3. **Continuous Deployment** — how it differs from Delivery, when teams use it

Write one real-world example for each.
# Task 2: CI vs CD

## 1. Continuous Integration (CI)

Continuous Integration is the practice of frequently merging code changes into a shared repository.  
Every code push automatically triggers builds and tests to catch bugs early and ensure the application still works correctly.

### What CI catches
- Build failures
- Syntax errors
- Broken tests
- Integration issues between developers' code

### Real-world Example
A developer pushes code to GitHub → GitHub Actions automatically runs tests and build checks before merging.

---

## 2. Continuous Delivery (CD)

Continuous Delivery ensures that the application is always in a deployable state after passing CI checks.  
Unlike CI, the code is automatically prepared for release, but deployment to production usually requires manual approval.

### What "Delivery" means
- Application is packaged
- Tested successfully
- Ready to deploy anytime

### Real-world Example
After tests pass, a Docker image is created and stored in DockerHub, waiting for the DevOps team to deploy it.

---

## 3. Continuous Deployment

Continuous Deployment automatically deploys every successful code change to production without manual approval.  
It extends Continuous Delivery by fully automating the release process.

### When teams use it
- Fast-moving SaaS companies
- Cloud-native applications
- Companies with strong automated testing systems

### Real-world Example
Netflix automatically deploys new updates to production after all tests pass successfully.

---

## Key Difference

| Practice | Main Purpose | Manual Approval Needed? |
|----------|---------------|--------------------------|
| CI | Build and test code frequently | No |
| Continuous Delivery | Keep code ready for deployment | Yes |
| Continuous Deployment | Automatically release to production | No |

---

### Task 3: Pipeline Anatomy
A pipeline has these parts — write what each one does:
- **Trigger** — what starts the pipeline
- **Stage** — a logical phase (build, test, deploy)
- **Job** — a unit of work inside a stage
- **Step** — a single command or action inside a job
- **Runner** — the machine that executes the job
- **Artifact** — output produced by a job


# Task 3: Pipeline Anatomy

A CI/CD pipeline is made up of multiple components that work together to automate software building, testing, and deployment.

---

| Component | Detailed Explanation | Real Example |
|------------|----------------------|---------------|
| **Trigger** | A trigger is the event that automatically starts the pipeline execution. Without a trigger, the CI/CD system would not know when to run the workflow. Triggers help automate the software delivery process whenever developers make changes. | A developer pushes code to the `main` branch → GitHub Actions pipeline starts automatically. |
| **Stage** | A stage is a logical section of the pipeline where similar tasks are grouped together. Pipelines are usually divided into stages such as Build, Test, and Deploy. Stages help organize the workflow and make debugging easier if failures happen. | Build Stage → compiles application code. Test Stage → runs unit tests. Deploy Stage → deploys application to server. |
| **Job** | A job is a specific unit of work inside a stage. Each stage can contain one or multiple jobs. Jobs usually run independently and can sometimes run in parallel to save time. Every job executes on a runner machine. | A `test-job` runs all automated tests. A `docker-build-job` creates the Docker image. |
| **Step** | A step is a single command or action executed inside a job. Steps are executed sequentially. Multiple steps together complete a job. Steps may include installing dependencies, running scripts, or executing shell commands. | `npm install`, `mvn test`, `docker build -t app .` |
| **Runner** | A runner is the machine or environment that executes pipeline jobs. It can be provided by GitHub (GitHub-hosted runner) or managed by the organization itself (self-hosted runner). Runners provide CPU, memory, OS, and tools needed for execution. | Ubuntu virtual machine running GitHub Actions workflow. |
| **Artifact** | An artifact is the output produced during pipeline execution. Artifacts are stored and can be reused in later stages or downloaded later. Artifacts help transfer build outputs between stages. | Docker image, compiled JAR file, ZIP package, test report, build logs. |

---

# How These Components Work Together

```text
Trigger
   ↓
Pipeline Starts
   ↓
Stage
   ↓
Job
   ↓
Step
   ↓
Artifact Generated
```

---

# Real CI/CD Pipeline Example

```text
Developer Pushes Code
        ↓
Trigger Activates Pipeline
        ↓
────────────────────────────
Stage 1: Build
────────────────────────────
Job: Build Application
    └── Step 1: Install Dependencies
    └── Step 2: Compile Code
    └── Step 3: Build Application
        ↓
Artifact Produced:
    └── Application Build File
        ↓
────────────────────────────
Stage 2: Test
────────────────────────────
Job: Run Tests
    └── Step 1: Run Unit Tests
    └── Step 2: Run Lint Checks
        ↓
Artifact Produced:
    └── Test Reports
        ↓
────────────────────────────
Stage 3: Deploy
────────────────────────────
Job: Deploy Application
    └── Step 1: Pull Docker Image
    └── Step 2: Deploy to Server
        ↓
Application Running Successfully
```

---

# Why Pipeline Anatomy Is Important

Understanding pipeline anatomy helps developers:

- Automate repetitive tasks
- Detect bugs early
- Improve deployment speed
- Reduce manual errors
- Maintain software quality
- Build reliable DevOps workflows

---

# Key Takeaway

Every CI/CD pipeline is built using:
- Triggers
- Stages
- Jobs
- Steps
- Runners
- Artifacts

These components work together to automate the software delivery lifecycle efficiently and safely.
---

### Task 4: Draw a Pipeline
Draw a CI/CD pipeline for this scenario:
> A developer pushes code to GitHub. The app is tested, built into a Docker image, and deployed to a staging server.
Developer
   │
   │ Push Code
   ▼
GitHub Repository
   │
   │ Trigger Pipeline
   ▼
CI/CD Pipeline
-------------------------------------------------
Stage 1: Build
    └── Install dependencies
    └── Build application

Stage 2: Test
    └── Run unit tests
    └── Run lint checks

Stage 3: Docker Build
    └── Build Docker image
    └── Push image to DockerHub

Stage 4: Deploy
    └── Deploy container to staging server
-------------------------------------------------

Result:
Application running on Staging Server
Include at least 3 stages. Hand-drawn and photographed is perfectly fine.

<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/4c78512a-697e-4906-b382-0c90934d15a5" />


---

### Task 5: Explore in the Wild
1. Open any popular open-source repo on GitHub (Kubernetes, React, FastAPI — pick one you know)
2. Find their `.github/workflows/` folder
3. Open one workflow YAML file
4. Write in your notes:
   - What triggers it?
   - How many jobs does it have?
   - What does it do? (best guess)

# Task 5: Explore in the Wild

## Repository Explored

Repository Name: FastAPI

GitHub Repository:
https://github.com/fastapi/fastapi

---

## Workflow Folder

```text
.github/workflows/
```

---

## Workflow File Explored

```text
test.yml
```

---

## What triggers it?

- push
- pull_request

Example:

```yaml
on:
  push:
  pull_request:
```

---

## How many jobs does it have?

The workflow contains multiple jobs such as:
- Testing
- Validation
- Linting

---

## What does it do?

The workflow:
- Installs dependencies
- Runs tests
- Checks code formatting
- Validates pull requests

This helps maintain code quality and stability.

---

# Key Takeaways

- CI/CD automates software delivery
- It reduces manual errors
- It improves reliability
- Pipelines help catch bugs early
- Automation allows faster deployments

---
