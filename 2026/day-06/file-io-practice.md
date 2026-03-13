<img width="933" height="406" alt="image" src="https://github.com/user-attachments/assets/1515de05-1560-4260-b217-8ac46ca54af5" />

# Day 06 – Linux Fundamentals: File Read & Write Practice

## Goal
Practice basic file operations in Linux using simple commands to create, write, append, and read text files.

---

## 1. Create an Empty File

Command:
touch notes.txt

Explanation:
Creates an empty file named notes.txt.

---

## 2. Write Text to File (Overwrite Mode)

Command:
echo "Line 1 - Linux file practice" > notes.txt

Explanation:
The `>` operator writes text to the file and overwrites any existing content.

---

## 3. Append Text to File

Command:
echo "Line 2 - Learning file redirection" >> notes.txt

Explanation:
The `>>` operator appends new content to the file without deleting existing data.

---

## 4. Write and Display Using tee

Command:
echo "Line 3 - Using tee command" | tee -a notes.txt

Explanation:
`tee` writes the output to the file and also displays it in the terminal.
`-a` means append to the file.

---

## 5. Read the Full File

Command:
cat notes.txt

Explanation:
Displays the entire contents of the file.

---

## 6. Read First 2 Lines

Command:
head -n 2 notes.txt

Explanation:
Shows the first two lines of the file.

---

## 7. Read Last 2 Lines

Command:
tail -n 2 notes.txt

Explanation:
Displays the last two lines of the file.

---

## Final File Content Example

Line 1 - Linux file practice  
Line 2 - Learning file redirection  
Line 3 - Using tee command

---

## Key Learning

- `>` overwrites a file
- `>>` appends data to a file
- `cat` reads the entire file
- `head` and `tail` help inspect parts of files
- `tee` writes and prints output at the same time

These commands are useful for reading logs, editing configuration files, and debugging systems in DevOps environments.
