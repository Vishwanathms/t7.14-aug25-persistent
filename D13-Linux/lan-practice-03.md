
# **Linux Lab Practice: User and Group Management**

---

## **Lab 1: User Management**

### 1. Create a new user

```bash
sudo useradd student1
```

✅ This creates user `student1`.

**Verify:**

```bash
id student1
```

Expected output:

```
uid=1001(student1) gid=1001(student1) groups=1001(student1)
```

---

### 2. Set password for user

```bash
sudo passwd student1
```

Enter new password → confirm.

**Verify by switching user:**

```bash
su - student1
whoami
```

Expected output:

```
student1
```

---

### 3. Create user with home directory and shell

```bash
sudo useradd -m -s /bin/bash student2
```

✅ `-m` creates home directory `/home/student2`, `-s` sets default shell.

**Verify:**

```bash
ls -ld /home/student2
grep student2 /etc/passwd
```

---

### 4. Delete a user

```bash
sudo userdel student1
```

(Delete with home directory:)

```bash
sudo userdel -r student1
```

✅ Removes user account (and home if `-r` used).

**Verify:**

```bash
id student1
```

Expected output:

```
id: ‘student1’: no such user
```

---

## **Lab 2: Group Management**

### 1. Create a group

```bash
sudo groupadd devteam
```

**Verify:**

```bash
grep devteam /etc/group
```

Expected output:

```
devteam:x:1002:
```

---

### 2. Add user to group

```bash
sudo usermod -aG devteam student2
```

✅ `-aG` means append to group.

**Verify:**

```bash
groups student2
```

Expected output:

```
student2 : student2 devteam
```

---

### 3. Change a user’s primary group

```bash
sudo usermod -g devteam student2
```

**Verify:**

```bash
id student2
```

Expected output: `gid=1002(devteam)`

---

### 4. Remove user from group

```bash
sudo gpasswd -d student2 devteam
```

**Verify:**

```bash
groups student2
```

Expected output: group `devteam` missing.

---

### 5. Delete a group

```bash
sudo groupdel devteam
```

**Verify:**

```bash
grep devteam /etc/group
```

Expected: No entry found.

---

## **Lab 3: User and Group Permissions**

### 1. Assign file ownership to a user

```bash
touch project.txt
sudo chown student2 project.txt
ls -l project.txt
```

Expected output:

```
-rw-r--r-- 1 student2 user 0 Sep 15 10:00 project.txt
```

---

### 2. Assign group ownership

```bash
sudo chown :devteam project.txt
ls -l project.txt
```

Expected output:

```
-rw-r--r-- 1 student2 devteam 0 Sep 15 10:00 project.txt
```

---

### 3. Give group write permissions

```bash
chmod g+w project.txt
ls -l project.txt
```

Expected output:

```
-rw-rw-r-- 1 student2 devteam 0 Sep 15 10:00 project.txt
```

---

## **Lab 4: Practice Exercises**

1. Create 3 users: `alice`, `bob`, `charlie`.
2. Create a group called `developers`.
3. Add `alice` and `bob` to `developers`.
4. Create a file `code.txt` owned by `alice` and group `developers`.
5. Give group `developers` write access to `code.txt`.
6. Switch to user `bob` and verify that he can edit `code.txt`.
7. Delete user `charlie` and remove group `developers`.

---

✅ **End of User & Group Management Lab**

