
## **1. Prerequisites**

* **Docker Desktop** installed and running (Windows/Mac/Linux).
* At least **2 GB RAM** allocated to Docker.
* Internet connectivity to pull images.

---

## **2. Pull the Jenkins Image**

Open a terminal (PowerShell, cmd, or bash) and run:

```bash
docker pull jenkins/jenkins:lts
```

This pulls the **Long-Term Support (LTS)** version of Jenkins.

---

## **3. Run Jenkins in a Container**

Run the container mapping ports and mounting volumes:
* Make sure to create the volume of "jenkins_home"
```
docker volume create jenkins_home
```

```bash
docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts
```

* `-p 8080:8080` → Jenkins web UI. You can change the host side port, if already 8080 is in use.
* `-p 50000:50000` → Communication with Jenkins agents.
* `-v jenkins_home:/var/jenkins_home` → Persistent data storage.


---

## **4. Get the Admin Password**

Check logs to find the initial password:

```bash
docker logs jenkins
```

Look for something like:

```
*************************************************************
Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:
xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
*************************************************************
```

---

## **5. Access Jenkins**

* Open a browser → [http://localhost:8080](http://localhost:8080)
* Enter the admin password.
* Choose “Install suggested plugins.”
* Create the first admin user.

---

## **6. Verify Installation**

Run:

```bash
docker ps
```

You should see Jenkins running.

---

✅ At this point, Jenkins is running inside Docker Desktop and accessible on `http://localhost:8080`.


