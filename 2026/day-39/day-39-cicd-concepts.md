# Day 39 – CI/CD Concepts

Task 1 – The Problem
Scenario

A team of 5 developers is working on the same project and manually deploying code to production.

What can go wrong?

Code conflicts

Developers may overwrite each other's changes.

Broken production

A developer might deploy untested code.

Human errors

Someone may forget a deployment step.

Different environments

Code might work locally but fail on the server.

Slow deployments

Manual deployments take time and reduce productivity.

What does "It works on my machine" mean?

This phrase means the code works correctly on the developer’s computer but fails in another environment (like staging or production).

Reasons:

Different OS

Different dependency versions

Missing environment variables

Different configurations

This is a real problem because it creates unpredictable production failures.

How many times can a team safely deploy manually?

Usually 1–2 deployments per day at most.

Manual deployment is slow and risky.

CI/CD allows teams to deploy multiple times per day safely.


Task 2 – CI vs CD
Continuous Integration (CI)

Continuous Integration means developers frequently merge code into a shared repository.
Every commit automatically runs builds and tests to detect errors early.

Example:
A developer pushes code to GitHub → tests run automatically.

Real-world example:
GitHub Actions runs tests every time code is pushed.

Continuous Delivery (CD)

Continuous Delivery ensures that the codebase is always ready for deployment.
After CI passes, the application is automatically built and prepared for release, but deployment requires manual approval.

Example:
Code passes tests → build is ready → team manually deploys to production.

Continuous Deployment

Continuous Deployment automatically deploys every change that passes tests directly to production.

No manual approval is required.

Example:
A commit passes tests → automatically deployed to production.

Companies like Netflix and Amazon use continuous deployment.

Task 3 – Pipeline Anatomy
Trigger

A trigger is an event that starts the pipeline.

Examples:

Git push

Pull request

Scheduled run

Manual trigger

Stage

A stage is a logical phase in the pipeline.

Examples:

Build

Test

Deploy

Stages run sequentially.

Job

A job is a set of tasks executed on a runner inside a stage.

Example:
A testing stage might have jobs like:

Unit tests

Integration tests

Step

A step is a single command inside a job.

Example:

npm install
npm test
docker build .
Runner

A runner is the machine that executes pipeline jobs.

Examples:

GitHub-hosted runner

Self-hosted runner

CI server

Artifact

Artifacts are files produced during pipeline execution.

Examples:

Compiled binaries

Docker images

Build logs

Test reports

Artifacts are passed between stages.

Task 4 – CI/CD Pipeline Diagram

Scenario:
A developer pushes code → tests run → Docker image is built → deployed to staging.





## Task 4: CI/CD Pipeline Diagram


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


 Task 5 – Exploring a Real GitHub Repository

Repository explored:
fastapi GitHub repository

https://github.com/fastapi/fastapi/blob/master/.github/workflows/contributors.yml

Workflow folder:

.github/workflows/

Example workflow file:

contributors.yml

name: FastAPI People Contributors

on:
  schedule:
    - cron: "0 3 1 * *"
  workflow_dispatch:
    inputs:
      debug_enabled:
        description: "Run the build with tmate debugging enabled (https://github.com/marketplace/actions/debugging-with-tmate)"
        required: false
        default: "false"

jobs:
  job:
    if: github.repository_owner == 'fastapi'
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - name: Dump GitHub context
        env:
          GITHUB_CONTEXT: ${{ toJson(github) }}
        run: echo "$GITHUB_CONTEXT"
      - uses: actions/checkout@v6
      - name: Set up Python
        uses: actions/setup-python@v6
        with:
          python-version-file: ".python-version"
      - name: Setup uv
        uses: astral-sh/setup-uv@v7
        with:
          enable-cache: true
          cache-dependency-glob: |
            pyproject.toml
            uv.lock
      - name: Install Dependencies
        run: uv sync --locked --no-dev --group github-actions
      # Allow debugging with tmate
      - name: Setup tmate session
        uses: mxschmitt/action-tmate@v3
        if: ${{ github.event_name == 'workflow_dispatch' && github.event.inputs.debug_enabled == 'true' }}
        with:
          limit-access-to-actor: true
        env:
          GITHUB_TOKEN: ${{ secrets.FASTAPI_PR_TOKEN }}
      - name: FastAPI People Contributors
        run: uv run ./scripts/contributors.py
        env:
          GITHUB_TOKEN: ${{ secrets.FASTAPI_PR_TOKEN }}

What triggers it?

It is triggered by:

Push events

Pull requests

How many jobs does it have?

The workflow has multiple jobs, such as:

Build

Test

Lint

What does it do?

Best guess:

The workflow ensures that:

Code compiles successfully

Tests pass

Code follows linting rules

Pull requests do not break the project

This helps maintain code quality and stability.

Key Takeaways

CI/CD automates software delivery.

CI focuses on integration and testing.

CD focuses on deployment readiness or automation.

Pipelines reduce manual work and human error.

A failing pipeline is helpful because it prevents broken code from reaching production.
