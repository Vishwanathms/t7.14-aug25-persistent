Absolutely! Here’s a **detailed lab manual** for **registering a GitLab Runner with your project or group** and **installing/registering a shell executor runner**. This guide is hands-on, practical, and step-by-step.

---

# **Lab Manual: Registering a GitLab Runner (Shell Executor)**

---

## **Objective**

* Install GitLab Runner on a Linux VM or server
* Register the runner with your GitLab project/group
* Configure the runner as a shell executor
* Verify runner registration and use

---

## **Pre-requisites**

* A working GitLab instance (self-hosted or gitlab.com)
* Access to a Linux VM (Ubuntu recommended) with internet access
* Your GitLab project/group URL and login
* Sudo/root privileges on your Linux machine

---

## **Step 1: Install GitLab Runner**

### **On Ubuntu/Debian:**

```bash
sudo apt-get update
sudo apt-get install -y curl
curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
sudo chmod +x /usr/local/bin/gitlab-runner
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start
```

**Alternative:**
You can also use the official GitLab package:

```bash
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get install gitlab-runner
```

---

## **Step 2: Get Your Registration Token**

1. **Log in to GitLab** and navigate to your project or group.
2. Go to:
   `Settings` → `CI / CD` → Expand the **Runners** section.
3. Copy the **registration token** (Project or Group registration token).

---

## **Step 3: Register the GitLab Runner**

On your Linux machine, run:

```bash
sudo gitlab-runner register
```

**You’ll be prompted for the following details:**

* **URL:**
  Enter your GitLab instance URL (e.g., `https://gitlab.com` or your self-hosted URL)

* **Registration token:**
  Paste the token you copied in Step 2

* **Description:**
  Enter a name for the runner (e.g., `shell-runner-01`)

* **Tags:**
  (Optional, comma-separated) e.g., `shell,lab,ci`

* **Executor:**
  Type: `shell`

Example prompt (with user input in **bold**):

```
Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
**https://gitlab.com**
Please enter the gitlab-ci token for this runner:
**<your_token_here>**
Please enter the gitlab-ci description for this runner:
**shell-runner-01**
Please enter the gitlab-ci tags for this runner (comma separated):
**shell,lab,ci**
Please enter the executor: ssh, docker+machine, docker-ssh+machine, kubernetes, docker, parallels, shell, virtualbox, docker-ssh, ssh, custom, docker-windows, process, instance:
**shell**
```

---

## **Step 4: Verify the Runner**

* Go back to your GitLab project/group → **Settings** → **CI/CD** → **Runners**
* Your runner (`shell-runner-01`) should now appear as **active**.

---

## **Step 5: Test the Runner**

1. Add a simple `.gitlab-ci.yml` to your repo:

   ```yaml
   test-shell:
     script:
       - echo "Runner is working!"
   ```

2. Commit and push the file.

3. GitLab will trigger a pipeline.

   * The job will run using your shell runner.
   * You can view the pipeline and logs in the **CI/CD > Pipelines** section of your project.

---

## **Common Commands (for reference)**

* **List registered runners:**

  ```bash
  sudo gitlab-runner list
  ```
* **Unregister a runner:**

  ```bash
  sudo gitlab-runner unregister --name "shell-runner-01"
  ```
* **Stop/start runner service:**

  ```bash
  sudo gitlab-runner stop
  sudo gitlab-runner start
  ```

---

## **Troubleshooting Tips**

* If the runner shows as "stuck" or "offline," check:

  * The machine is running and has network access.
  * The registration token and URL are correct.
  * The user running `gitlab-runner` has correct permissions.
* Check runner logs:

  ```bash
  sudo journalctl -u gitlab-runner
  ```

---

# **Lab Recap**

* You installed GitLab Runner, registered it with your project/group, configured it as a shell executor, and ran a test job.
* Now your runner is ready for any CI/CD job in your GitLab project!

---

**Let me know if you want this as a downloadable doc, need screenshots, or wish to see the steps for Docker executor!**
