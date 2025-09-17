# **Linux Lab Practice: File & Folder Permissions + Search Options**

---

## **Lab 1: File & Folder Permissions**

### 1. Create files and directories

```bash
mkdir perm_lab
cd perm_lab
touch file1.txt
mkdir dir1
ls -l
```

✅ Expected: `file1.txt` and `dir1` are created with default permissions.

---

### 2. Understanding permissions

```bash
ls -l
```

✅ Example Output:

```
-rw-r--r--  1 user user   0 Sep 15 10:00 file1.txt
drwxr-xr-x  2 user user  40 Sep 15 10:00 dir1
```

* `r` → read
* `w` → write
* `x` → execute

---

### 3. Change permissions using `chmod`

1. **Add execute permission**

   ```bash
   chmod +x file1.txt
   ls -l file1.txt
   ```

   ✅ Output: `-rwxr--r-- file1.txt`

2. **Remove read permission for group**

   ```bash
   chmod g-r file1.txt
   ls -l file1.txt
   ```

   ✅ Output: Group lost `r`.

3. **Set numeric permissions (e.g., 755)**

   ```bash
   chmod 755 file1.txt
   ls -l file1.txt
   ```

   ✅ Output: `-rwxr-xr-x`

---

### 4. Change ownership using `chown`

```bash
sudo chown root file1.txt
ls -l file1.txt
```

✅ Output: Owner changes from `user` → `root`.

---

### 5. Directory permissions

1. **Remove execute from dir**

   ```bash
   chmod -x dir1
   ls dir1
   ```

   ✅ Expected: Permission denied.

2. **Restore execute permission**

   ```bash
   chmod +x dir1
   ls dir1
   ```

   ✅ Output: Directory accessible again.

---

## **Lab 2: Searching Files and Text**

### 1. Find files using `find`

1. **Find all `.txt` files in current directory**

   ```bash
   find . -name "*.txt"
   ```

   ✅ Output: `./file1.txt`

2. **Find files modified in last 1 day**

   ```bash
   find . -mtime -1
   ```

   ✅ Output: Recently created files.

3. **Find empty files**

   ```bash
   find . -type f -empty
   ```

   ✅ Output: Lists empty files.

---

### 2. Locate files using `locate` (may need `sudo updatedb`)

```bash
locate file1.txt
```

✅ Output: Shows path of `file1.txt`.

---

### 3. Search text inside files using `grep`

1. **Simple search**

   ```bash
   echo "Linux is powerful" > file1.txt
   grep "Linux" file1.txt
   ```

   ✅ Output: `Linux is powerful`

2. **Case-insensitive search**

   ```bash
   grep -i "linux" file1.txt
   ```

   ✅ Output: `Linux is powerful`

3. **Search recursively inside directory**

   ```bash
   grep -r "Linux" .
   ```

   ✅ Output: Shows matching lines in files.

---

### 4. Advanced `grep` usage

1. **Show line numbers**

   ```bash
   grep -n "Linux" file1.txt
   ```

   ✅ Output: `1:Linux is powerful`

2. **Count occurrences**

   ```bash
   grep -c "Linux" file1.txt
   ```

   ✅ Output: `1`

---

## **Lab 3: Combined Practice Task**

1. Create 3 files: `doc1.txt`, `doc2.txt`, `doc3.txt`.
2. Write some text in each file.
3. Remove read permission for `doc2.txt`. Try opening it.
4. Give execute permission to `doc3.txt` and run:

   ```bash
   ./doc3.txt
   ```

   (Add `#!/bin/bash` and some commands inside to test).
5. Search all `.txt` files containing the word "Linux" in your home directory.
6. Find and delete all empty `.log` files in `/tmp`.

---

✅ **End of Lab**

This lab ensures students **understand permission changes** and **get hands-on with search utilities** (`find`, `locate`, `grep`).

