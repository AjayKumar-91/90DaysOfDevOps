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


# 📝 File & Directory Operations


touch [file] – Create a new empty file or update the timestamp.

mkdir [dir] – Create a new directory, use -p [dir/subdir] to create parent directories as needed.

cp [source] [dest] – Copy files or directories, use -r for directories.

mv [source] [dest] – Move or rename files/directories.

rm [file] – Remove/delete a file.

rm -r [dir] – Remove a directory and its contents, use -rf to force removal without prompting.

rmdir [dir] – Remove an empty directory.

ln -s [source] [link] – Create a symbolic link (shortcut) to a file.


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


# 📦 Archiving & Compression


tar -cvf [archive.tar] [dir] – Create an uncompressed tar archive, use -czvf for gzip compression.

tar -xvf [archive.tar] – Extract a tar archive, use -xzvf for gzip.

zip -r [archive.zip] [dir] and unzip [archive.zip] – Create or extract zip archives.
