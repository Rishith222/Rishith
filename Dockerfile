# **Base Image for Compilation**
FROM alpine AS compile-image

# Install dependencies
RUN apk update && apk add --no-cache \
    python3 \
    py-pip \
    openssl \
    ca-certificates \
    python3-dev \
    build-base \
    wget \
    curl \
    unzip \
    docker


# Set working directory
WORKDIR /myapp

# Copy dependencies and install them in a virtual environment
COPY requirements.txt .
RUN python3 -m venv /myapp
RUN /myapp/bin/pip install -r requirements.txt

FROM jenkins/jenkins:lts

# Switch to root user to install packages
USER root

# Install Docker inside the container
RUN apt update && apt install -y docker.io

# Allow the 'jenkins' user to use Docker
RUN usermod -aG docker jenkins

# Switch back to the Jenkins user
USER jenkins


# **Final Runtime Image**
FROM python:3.9

# Set working directory
WORKDIR /myapp

# Copy application files
COPY myapp.py .
COPY --from=compile-image /myapp/ ./

# Install additional runtime dependencies
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip && \
    unzip terraform_1.6.0_linux_amd64.zip -d /usr/local/bin/ && \
    rm terraform_1.6.0_linux_amd64.zip

# Keep container running and start the app
CMD ["sh", "-c", "python3 /myapp/myapp.py && tail -f /dev/null"]

