# 🧪 Lab: New Relic Container Deployment & Agent Integration

---

## **1. Prerequisites**

* Docker or Kubernetes environment ready.
* New Relic account (with **License Key**).
* Python sample app (Flask/Django/FastAPI).
* Redis container for caching.

---

## **2. Deploy New Relic Infrastructure Agent (Container-Based)**

New Relic provides an **infrastructure agent container**.

### **Steps**

1. Create a `docker-compose.yaml` file:

```yaml
version: "3"
services:
  newrelic-infra:
    image: newrelic/infrastructure:latest
    container_name: newrelic-infra
    privileged: true
    network_mode: host
    environment:
      - NRIA_LICENSE_KEY=<YOUR_NEW_RELIC_LICENSE_KEY>
      - NRIA_DISPLAY_NAME=docker-desktop-lab
    volumes:
      - "/:/host:ro"
      - "/var/run/docker.sock:/var/run/docker.sock"
```

2. Deploy:

```bash
docker-compose up -d
```

3. Verify:

```bash
docker logs newrelic-infra
```

👉 After a few minutes, the host and container metrics appear in **New Relic Infrastructure**.

---

## **3. Instrument Python Container**

You’ll need the **New Relic Python agent**.

### **Steps**

1. Add **newrelic package** to your Python app:

```bash
pip install newrelic
```

2. Generate a config file:

```bash
newrelic-admin generate-config <YOUR_NEW_RELIC_LICENSE_KEY> newrelic.ini
```

3. Modify `Dockerfile` for Python app:

```dockerfile
FROM python:3.10-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN pip install newrelic

COPY . .

CMD ["newrelic-admin", "run-program", "python", "app.py"]
```

4. Mount the `newrelic.ini` file:

```yaml
python-app:
  build: .
  container_name: python-app
  environment:
    - NEW_RELIC_CONFIG_FILE=/app/newrelic.ini
```

👉 This ensures all Python transactions (Flask/Django/Redis calls) are traced in New Relic APM.

---

## **4. Instrument Redis Container**

Redis doesn’t have a direct New Relic agent but can be monitored via **integration container**.

### **Steps**

1. Use the New Relic **Redis on-host integration** inside your infra agent container.
   Update your `docker-compose.yaml`:

```yaml
  newrelic-redis:
    image: newrelic/infrastructure-bundle:latest
    container_name: newrelic-redis
    environment:
      - NRIA_LICENSE_KEY=<YOUR_NEW_RELIC_LICENSE_KEY>
      - NRIA_DISPLAY_NAME=redis-monitor
    volumes:
      - "/:/host:ro"
      - "/var/run/docker.sock:/var/run/docker.sock"
      - "./redis-integration.yml:/etc/newrelic-infra/integrations.d/redis-integration.yml"
```

2. Create **redis-integration.yml**:

```yaml
integrations:
  - name: nri-redis
    env:
      HOSTNAME: redis
      PORT: 6379
    labels:
      env: lab
      role: cache
```

3. Run containers:

```bash
docker-compose up -d
```

👉 Now Redis metrics (memory, connections, ops/sec) will show in New Relic.

---

## **5. Validate in New Relic**

* Go to **APM → Python App**: See transactions, database calls, Redis queries.
* Go to **Infrastructure → Hosts/Containers**: See Docker metrics.
* Go to **Dashboards → Redis**: Confirm Redis integration metrics.

---

✅ At this point, you have:

* **New Relic Infra Agent** running as a container.
* **Python App** instrumented with New Relic APM.
* **Redis** monitored via Redis integration.

