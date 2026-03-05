# Day 38 – YAML Basics

## Task Overview
Today I learned the basics of YAML syntax which is used in CI/CD pipelines like GitHub Actions, GitLab CI, Kubernetes manifests, and Docker Compose.

---

# Task 1 – Key Value Pairs

Created `person.yaml`

Example:

name: Ajay Kumar  
role: Java Developer  
experience_years: 3+  
learning: true  

---

# Task 2 – Lists

Two ways to write lists in YAML:


# Task 3 – Nested Objects

Created `server.yaml` with nested structure.


# Task 4 – Multi-line Strings

### Pipe ( | ) — Preserves new lines

Used for scripts or logs.


### Greater Than ( > ) — Converts to single line

Used for long text paragraphs


# Task 5 – YAML Validation

Installed yamllint:

sudo apt install yamllint

Validation command:

yamllint person.yaml

yamllint server.yaml



### Block Style

