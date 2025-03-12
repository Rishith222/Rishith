# **Base Image for Compilation**
FROM alpine AS compile-image

# Install dependencies in Alpine
RUN apk update && apk add --no-cache \
    python3 \
    py3-pip \
    openssl \
    ca-certificates \
    python3-dev \
    build-base \
    wget \
    curl \
    unzip \
    docker-cli  # Install Docker CLI

# Set working directory
WORKDIR /myapp

# Copy dependencies and install them in a virtual environment
COPY requirements.txt .
RUN python3 -m venv /myapp
RUN /myapp/bin/pip install -r requirements.txt

# **Final Runtime Image with Jenkins & Docker**
FROM jenkins/jenkins:lts

# Switch to root user to install packages
USER root

# Install Docker
RUN apt update && apt install -y docker.io

# Add Jenkins user to Docker group
RUN usermod -aG docker jenkins

# Ensure Docker is in the PATH
ENV PATH="/usr/bin:$PATH"

# **Setup Jenkins User Home & Permissions**
RUN mkdir -p /home/jenkins && chown -R jenkins:jenkins /home/jenkins

# Install additional runtime dependencies
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip && \
    unzip terraform_1.6.0_linux_amd64.zip -d /usr/local/bin/ && \
    rm terraform_1.6.0_linux_amd64.zip

# Set working directory
WORKDIR /myapp

# Copy application files
COPY myapp.py .
COPY --from=compile-image /myapp/ ./



# Switch back to Jenkins user
USER jenkins


# **Download Jenkins Agent JAR**
RUN wget -O /home/jenkins/agent.jar http://158.101.11.87:8080/jnlpJars/agent.jar

# Keep container running and start the app
CMD ["sh", "-c", "python3 /myapp/myapp.py && tail -f /dev/null"]

