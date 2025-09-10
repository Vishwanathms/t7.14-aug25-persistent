Great! If **GitLab is running on `localhost:8080`** (e.g., on your laptop/desktop or in a VM/Container with port 8080 mapped), the runner registration and setup commands/flows should be adjusted accordingly.

Below is the **corrected and streamlined lab manual** for a Docker-based runner, assuming your GitLab instance is available at `http://localhost:8080`.

---

# **Lab Manual: Registering a Docker-Based GitLab Runner (GitLab on `localhost:8080`)**

---

## **Pre-requisites**

* **GitLab CE/EE** is running and accessible at [http://localhost:8080](http://localhost:8080) on your machine
* **Docker** is installed and running
* You have **sudo/admin** privileges

---

## **Step 1: Create Persistent Config Directory**

```bash
mkdir -p /srv/gitlab-runner/config
```

---

## **Step 2: Run GitLab Runner Container**

```bash
docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest
```

---

## **Step 3: Get Your Registration Token**

1. Log into your GitLab at [http://localhost:8080](http://localhost:8080).
2. Go to your **Project** or **Group**:

   * **Project:** Settings > CI/CD > Expand **Runners** > Copy **Registration token**
   * **Group:** Settings > CI/CD > Runners > Copy **Registration token**

---

## **Step 4: Register the Runner (with Docker Executor)**

Run this command to start an interactive registration process:

```bash
docker exec -it gitlab-runner gitlab-runner register
```

**When prompted, enter the following:**

* **URL:**

  ```
  http://host.docker.internal:8080
  ```

  > This allows the Docker runner container to access your GitLab instance running on your Windows/Mac host.

  > On Linux, use your machine's IP address, not `localhost` (since `localhost` inside the runner container refers to itself).

* **Registration Token:** (Paste what you copied)

* **Description:** (Any name, e.g. `docker-runner-local`)

* **Tags:** (Optional, e.g. `docker,local`)

* **Executor:**

  ```
  docker
  ```

* **Default Docker image:**

  ```
  alpine:latest
  ```

**Example registration session:**

```
Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
http://host.docker.internal:8080
Please enter the gitlab-ci token for this runner:
<your_token>
Please enter the gitlab-ci description for this runner:
docker-runner-local
Please enter the gitlab-ci tags for this runner (comma separated):
docker,local
Please enter the executor: docker, shell, etc:
docker
Please enter the default Docker image (e.g. ruby:2.7):
alpine:latest
```

---

## **Step 5: Verify the Runner**

* In your GitLab UI ([http://localhost:8080](http://localhost:8080)), go to **Settings > CI/CD > Runners** and confirm your runner is listed as **active**.

---

## **Step 6: Test Your Runner**

Add a `.gitlab-ci.yml` file to your repo with:

```yaml
test-docker-runner:
  image: alpine:latest
  script:
    - echo "This job runs inside Docker!"
    - uname -a
```

* Commit and push this file.
* Check the **Pipelines** section in GitLab; your runner should pick up the job and execute it.

---

## **Key Notes for Localhost + Docker**

* On **Windows/Mac**, use `http://host.docker.internal:8080` as the URL **inside the runner registration** so the Docker container can talk to the GitLab host.
* On **Linux**, replace with the host machine’s local IP address (e.g., `http://192.168.1.100:8080`).
* Do **not** use `http://localhost:8080` or `127.0.0.1:8080` inside the container, as that points to the runner container itself, not your host’s GitLab.

---

## **Common Commands**

```bash
docker exec -it gitlab-runner gitlab-runner list
docker restart gitlab-runner
docker logs gitlab-runner
```

---

## **Troubleshooting**

* If the runner shows “stuck” or “offline,” double-check the registration URL and your firewall/NAT settings.
* Ensure Docker can communicate with your host’s GitLab (`host.docker.internal` for Windows/Mac).

---

**Let me know if you need a downloadable doc, screenshots, or have another setup scenario!**
