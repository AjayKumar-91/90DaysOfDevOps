This cheat sheet focuses on essential Linux/Unix commands for navigating, manipulating, managing permissions, and monitoring the file system.


# 📂 File System Navigation


pwd – Print the current working directory.

cd [dir] – Change directory to [dir].

cd .. – Move up one directory level.

cd ~ or cd – Change to the home directory.

cd - – Move to the previous directory.

ls – List files and directories.

ls -l – List files in long format (details: permissions, owner, size, date).

ls -a – List all files, including hidden files (those starting with .).

ls -lh – List files with human-readable sizes (e.g., 1K, 234M, 2G).

tree – View directory structure in a tree-like diagram.


# 📂 File System Navigation (Advanced)

ls -R – List directories recursively.

ls -lt – Sort files by modification time.

ls -ltr – Oldest files first.

stat [file] – Show detailed file information (size, permissions, timestamps).

realpath [file] – Show the absolute path of a file.

basename [path] – Extract file name from path.

dirname [path] – Extract directory path.


# 📝 File & Directory Operations


touch [file] – Create a new empty file or update the timestamp.

mkdir [dir] – Create a new directory, use -p [dir/subdir] to create parent directories as needed.

cp [source] [dest] – Copy files or directories, use -r for directories.

mv [source] [dest] – Move or rename files/directories.

rm [file] – Remove/delete a file.

rm -r [dir] – Remove a directory and its contents, use -rf to force removal without prompting.

rmdir [dir] – Remove an empty directory.

ln -s [source] [link] – Create a symbolic link (shortcut) to a file.

wc [file] – Count lines, words, and characters.


# 📄 File Content Processing

wc -l [file] – Count number of lines.

sort [file] – Sort lines in a file.

uniq [file] – Remove duplicate lines (usually used with sort).

cut -d',' -f1 file.csv – Extract specific column from file.

awk '{print $1}' file – Print first column of a file.

sed 's/old/new/g' file – Replace text in file output.

tr 'a-z' 'A-Z' – Convert lowercase to uppercase.


# 🧾 File Metadata & Timestamps

stat file – Show file metadata.

file filename – Detect file type.

touch -t YYYYMMDDHHMM file – Set custom timestamp.

ls -lc – Show file change time.

ls -lu – Show last access time.


# 🔗 Links (Hard & Symbolic)

ln file hardlink – Create hard link.

ln -s file symlink – Create symbolic link.

readlink symlink – Show where a symlink points.

ls -li – Show inode numbers.


# 📁 Directory Inspection

du -ah – Show disk usage of all files.

du -sh * – Show size of each item in current directory.

du -h --max-depth=1 – Directory size summary.

tree -L 2 – Show directory tree up to depth 2.



# 🔍 Searching & Viewing Files


cat [file] – Display the entire contents of a file.

less [file] – View file content page-by-page.

head -n [lines] [file] – Display the first n lines, tail -f [file] shows the last lines and follows in real-time.

find [path] -name "[pattern]" – Search for files/directories by name.

grep "[pattern]" [file] – Search for a specific string/pattern within a file.

locate [file] – Find files quickly using a database.

which [command] – Show the full path of an executable.


# 🔐 Permissions & Ownership


chmod [mode] [file] – Change file permissions (e.g., 755), use +x to make a file executable.

chown [user]:[group] [file] – Change file/directory ownership.

chgrp [group] [file] – Change group ownership.

ls -l – View current permissions.


# 💾 Disk Usage & Mounting


df -h – Check free space on mounted filesystems in human-readable format.

du -sh [path] – Summarize disk usage, use --max-depth=1 to check subdirectories.

mount and umount [mountpoint] – Display or unmount file systems.

lsblk – List block devices.


# 💽 Disk & Storage Inspection (Very Useful for DevOps)

df -Th – Show filesystem type.

du -xh / | sort -rh | head – Find largest directories.

lsblk -f – Show filesystem information.

blkid – Display block device UUIDs.

mount | column -t – View mounted filesystems nicely formatted.



# 🔎 Finding Large Files (Production Debugging)

find / -type f -size +100M – Find files larger than 100MB.

find /var/log -type f -name "*.log" – Find log files.

find . -type f -mtime -7 – Files modified in last 7 days.

find . -empty – Find empty files/directories.


# 🧹 File Cleanup

rm -i file – Ask before deleting.

rm -rf dir – Force delete directory.

find . -name "*.log" -delete – Delete log files.

truncate -s 0 file.log – Empty a file without deleting it.


# 📁 Special Directories (Linux Internals)

/dev – Device files.

/proc – Kernel and process information.

/sys – Kernel hardware interface.

/tmp – Temporary files.

/var/log – System logs.




# 📊 Inodes (Important for Production Servers)

df -i – Check inode usage.

stat file – Show inode number.

ls -i – Show inode numbers of files.


# 📦 Archiving & Compression


tar -cvf [archive.tar] [dir] – Create an uncompressed tar archive, use -czvf for gzip compression.

tar -xvf [archive.tar] – Extract a tar archive, use -xzvf for gzip.

zip -r [archive.zip] [dir] and unzip [archive.zip] – Create or extract zip archives.
