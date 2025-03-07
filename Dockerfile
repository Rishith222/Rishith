# Compile-time Image
FROM alpine AS compile-image

RUN apk add --no-cache \
    python3 \
    py-pip \
    openssl \
    ca-certificates \
    python3-dev \
    build-base \
    wget \
    curl \
    unzip

WORKDIR /myapp

COPY requirements.txt /myapp/
RUN python3 -m venv /myapp
RUN /myapp/bin/pip install -r requirements.txt

# Runtime Image
FROM alpine AS runtime-image

RUN apk add --no-cache \
    python3 \
    openssl \
    ca-certificates \
    curl \
    unzip

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip && \
    unzip terraform_1.6.0_linux_amd64.zip -d /usr/local/bin/ && \
    rm terraform_1.6.0_linux_amd64.zip

WORKDIR /myapp
COPY . /myapp
COPY --from=compile-image /myapp/ ./

CMD ["/myapp/bin/python", "myapp.py", "start"]

