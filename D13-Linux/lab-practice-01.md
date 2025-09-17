
# **Basic Linux Command Lab Practice Document (With Steps & Verification)**

---

## **Lab 1: Getting Started with Linux**

### Commands & Steps:

1. **Check current directory**

   ```bash
   pwd
   ```

   ✅ Output: `/home/username` (depends on your user)

2. **Check logged-in user**

   ```bash
   whoami
   ```

   ✅ Output: `username`

3. **Display date and calendar**

   ```bash
   date
   cal
   ```

   ✅ Output: Current date & monthly calendar.

---

## **Lab 2: File System Navigation**

### Commands & Steps:

1. **List files in current directory**

   ```bash
   ls
   ls -l
   ```

   ✅ Output: Shows files with details (permissions, owner, size, date).

2. **Change directory**

   ```bash
   cd /tmp
   pwd
   cd ~
   pwd
   ```

   ✅ Output: First `/tmp`, then `/home/username`.

3. **Create and verify folder**

   ```bash
   mkdir lab1
   tree lab1
   ```

   ✅ Output: `lab1` directory visible.

---

## **Lab 3: File & Directory Management**

### Commands & Steps:

1. **Create file and directory**

   ```bash
   touch notes.txt
   mkdir docs
   ls
   ```

   ✅ Output: `notes.txt` file and `docs` directory listed.

2. **Copy file**

   ```bash
   cp notes.txt docs/
   ls docs
   ```

   ✅ Output: `notes.txt` is inside `docs`.

3. **Rename file**

   ```bash
   mv notes.txt lab_notes.txt
   ls
   ```

   ✅ Output: `lab_notes.txt` present.

4. **Delete file**

   ```bash
   rm lab_notes.txt
   ls
   ```

   ✅ Output: File removed.

---

## **Lab 4: Viewing & Editing Files**

### Commands & Steps:

1. **Create file with text**

   ```bash
   echo "Hello Linux" > hello.txt
   cat hello.txt
   ```

   ✅ Output: `Hello Linux`

2. **Edit file**

   ```bash
   nano hello.txt   # OR vi hello.txt
   ```

   Add lines, save, and exit.

3. **View first & last lines**

   ```bash
   head -n 2 hello.txt
   tail -n 2 hello.txt
   ```

   ✅ Output: First 2 lines and last 2 lines shown.

---

## **Lab 5: File Permissions**

### Commands & Steps:

1. **Check file permissions**

   ```bash
   touch perm.txt
   ls -l perm.txt
   ```

   ✅ Output: Example → `-rw-r--r--`

2. **Remove execute permission**

   ```bash
   chmod a-x perm.txt
   ls -l perm.txt
   ```

   ✅ Output: No `x` in permissions.

3. **Add write permission for others**

   ```bash
   chmod o+w perm.txt
   ls -l perm.txt
   ```

   ✅ Output: `-rw-r--rw-`

---

## **Lab 6: Searching & Finding Files**

### Commands & Steps:

1. **Find `.txt` files**

   ```bash
   find ~ -name "*.txt"
   ```

   ✅ Output: Lists all `.txt` files in home.

2. **Search word inside file**

   ```bash
   grep "Linux" hello.txt
   grep -i "linux" hello.txt
   ```

   ✅ Output: Line containing `Linux` displayed.

---

## **Lab 7: User & System Information**

### Commands & Steps:

1. **Check logged-in users**

   ```bash
   who
   ```

   ✅ Output: Shows usernames & login times.

2. **Check uptime**

   ```bash
   uptime
   ```

   ✅ Output: System running time + load average.

3. **Check system info**

   ```bash
   uname -a
   ```

   ✅ Output: Kernel version & OS info.

4. **Check disk & memory**

   ```bash
   df -h
   free -m
   ```

   ✅ Output: Disk usage & memory usage shown.

---

## **Lab 8: Process Management**

### Commands & Steps:

1. **List processes**

   ```bash
   ps
   top
   ```

   ✅ Output: Shows running processes.

2. **Find your shell PID**

   ```bash
   echo $$
   ```

   ✅ Output: Current shell PID.

3. **Run & kill process**

   ```bash
   sleep 1000 &
   ps
   kill <PID>
   ```

   ✅ Output: Process stopped.

---

## **Lab 9: Archiving & Compression**

### Commands & Steps:

1. **Create directory & files**

   ```bash
   mkdir backup
   echo "file1" > backup/file1.txt
   echo "file2" > backup/file2.txt
   ```

2. **Archive**

   ```bash
   tar -cvf backup.tar backup/
   ls
   ```

   ✅ Output: `backup.tar` created.

3. **Compress**

   ```bash
   gzip backup.tar
   ls
   ```

   ✅ Output: `backup.tar.gz` present.

4. **Extract**

   ```bash
   gunzip backup.tar.gz
   tar -xvf backup.tar
   ls
   ```

   ✅ Output: Extracted `backup` folder.

---

## **Lab 10: Networking Basics**

### Commands & Steps:

1. **Check IP address**

   ```bash
   ip addr show
   ```

   ✅ Output: Shows system IP.

2. **Ping Google**

   ```bash
   ping -c 4 google.com
   ```

   ✅ Output: 4 successful replies.

3. **Download file**

   ```bash
   wget http://example.com
   ```

   ✅ Output: File downloaded.

---

✅ **End of Lab Practice**

