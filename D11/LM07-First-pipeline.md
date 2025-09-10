Certainly! Here’s a **step-by-step, detailed lab manual** for “Building Your First GitLab CI/CD Pipeline.”
This is practical, trainer-friendly, and covers **objectives, prerequisites, all commands, expected results, and troubleshooting**.

---

# **Lab Manual: Building Your First GitLab Pipeline**

---

## **Lab Objective**

* Understand the basics of `.gitlab-ci.yml` and GitLab pipelines.
* Create a pipeline with build and test stages.
* Observe the pipeline run and job status in the GitLab UI.

---

## **Prerequisites**

* GitLab account (gitlab.com or self-hosted)
* A sample repository (new or existing) where you can push commits
* Git installed on your machine
* Editor (VS Code, Sublime, Notepad++ or any code editor)
* (Optional) GitLab Runner configured (for self-hosted GitLab)

---

## **Step 1: Create or Clone a GitLab Repository**

1. **Login to GitLab.**
2. **Create a new project** (or choose an existing one).

   * Go to “New Project” → Fill in project name, visibility, etc.
   * Click **Create project**.
3. **Clone the repo to your local machine:**

   ```sh
   git clone https://gitlab.com/<your-username>/<your-repo>.git
   cd <your-repo>
   ```

---

## **Step 2: Create Your `.gitlab-ci.yml` File**

1. In the root directory of your project, create a new file called `.gitlab-ci.yml`.
2. Open it in your code editor.
3. **Copy and paste the following minimal pipeline:**

   ```yaml
   stages:
     - build
     - test

   build-job:
     stage: build
     script:
       - echo "Building the application..."

   test-job:
     stage: test
     script:
       - echo "Running tests..."
   ```

---

## **Step 3: Commit and Push the Pipeline File**

1. Save the file.
2. Run these commands to commit and push:

   ```sh
   git add .gitlab-ci.yml
   git commit -m "Add initial CI pipeline"
   git push
   ```

---

## **Step 4: View Pipeline Execution in GitLab**

1. In your browser, go to your GitLab project page.
2. Click on **CI/CD → Pipelines** in the left sidebar.
3. You should see a new pipeline started automatically.
4. Click the pipeline ID to view details.
5. Click each job (build-job, test-job) to see the logs.

**Expected Output:**

* Both jobs should pass with output:

  ```
  Building the application...
  ```

  and

  ```
  Running tests...
  ```

---

## **Step 5: Modify the Pipeline (Add More Realistic Steps)**

1. Edit `.gitlab-ci.yml` to add realistic build and test commands.
   Example for a Node.js project:

   ```yaml
   stages:
     - build
     - test

   build-job:
     stage: build
     script:
       - npm install

   test-job:
     stage: test
     script:
       - npm test
     artifacts:
       paths:
         - coverage/
   ```
2. Save, commit, and push:

   ```sh
   git add .gitlab-ci.yml
   git commit -m "Add Node.js build and test steps"
   git push
   ```

---

## **Step 6: Observe Job Artifacts**

1. Go to **CI/CD → Pipelines → \[Pipeline ID] → test-job**.
2. Look for the “Artifacts” section. Download and check the files if present.

---

## **Step 7: Experiment with Stages**

1. Add a `deploy` stage to your `.gitlab-ci.yml`:

   ```yaml
   deploy-job:
     stage: deploy
     script:
       - echo "Deploying application..."
   ```
2. Add `deploy` to the `stages:` section.
3. Commit and push.
4. Observe that the deploy job runs after build and test.

---

## **Step 8: Troubleshooting**

* **Pipeline not triggering?**

  * Check `.gitlab-ci.yml` is in the root and correctly named.
* **Jobs not running?**

  * Runner might be missing or misconfigured.
  * Check Settings → CI/CD → Runners.
* **Syntax errors?**

  * Use a YAML linter, or GitLab will display an error in the pipeline UI.
* **Job failed?**

  * Click the job name for detailed logs.

---

## **Step 9: Clean Up (Optional)**

* Delete your test repo if you do not need it.

---

## **Additional Exercises (Optional)**

* Add a job that runs only on the `main` branch.
* Use environment variables in your pipeline.
* Try a pipeline with a real project (Python, Java, etc.).

---

## **End of Lab**

---

**Would you like this exported as a formatted Word doc, or want sample screenshots for each step?**
