FROM ubuntu:22.04

LABEL maintainer="Your Name vishwa"
LABEL description="Jenkins Ubuntu Agent with Java, Git, Maven, Docker CLI, and Terraform"

# -----------------------------
# Install base dependencies + Java
# -----------------------------
RUN apt-get update && apt-get install -y \
    openjdk-11-jre \
    git \
    maven \
    curl \
    gnupg \
    lsb-release \
    ca-certificates \
    software-properties-common \
    sudo \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y iputils-ping && \
    rm -rf /var/lib/apt/lists/*

# -----------------------------
# Install Docker CLI
# -----------------------------
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && apt-get install -y docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*

# -----------------------------
# Install Terraform
# -----------------------------
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform && \
    rm -rf /var/lib/apt/lists/*

# -----------------------------
# Create Jenkins user + docker group
# -----------------------------
RUN groupadd -g 999 docker && \
    useradd -m -d /home/jenkins -s /bin/bash jenkins && \
    usermod -aG docker jenkins && \
    echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER jenkins
WORKDIR /home/jenkins
# -----------------------------
# Default command (override in Jenkins agent config)
# -----------------------------
CMD ["ping", "localhost"]

# -----------------------------
# Entrypoint: download agent.jar & connect
# Pass JENKINS_URL and JENKINS_SECRET when running container
# -----------------------------
ENTRYPOINT ["/bin/bash", "-c", "\
  curl -sO ${JENKINS_URL}/jnlpJars/agent.jar && \
  java -jar agent.jar -url ${JENKINS_URL} -secret ${JENKINS_SECRET} -name ${AGENT_NAME:-agent} -webSocket -workDir /home/jenkins/agent \
"]


