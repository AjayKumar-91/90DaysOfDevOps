# Day 40 – First GitHub Actions Workflow

## Repository
github-actions-practice

## Workflow File

.github/workflows/hello.yml

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


        
