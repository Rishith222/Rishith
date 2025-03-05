<<<<<<< HEAD
terraform {
  required_providers {
<<<<<<< HEAD
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
=======
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
>>>>>>> 2051675 (Update main.tf)
    }
  }
}

<<<<<<< HEAD
provider "docker" {
  host = "unix:///var/run/docker.sock"  # Ensure Jenkins has access to this
}

resource "docker_image" "jenkins_agent" {
  name = "my-jenkins-agent:latest"
  keep_locally = true
}

resource "docker_container" "jenkins_docker_agent" {
  name  = "jenkins-docker-agent"
  image = docker_image.jenkins_agent.name

  # Attach Docker socket for Jenkins agent to run containers
  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  # Set Jenkins workspace
  volumes {
    host_path      = "/var/lib/jenkins/workspace"
    container_path = "/var/lib/jenkins/workspace"
  }

  # Expose ports if needed
  ports {
    internal = 8080
    external = 8081
  }

  restart = "always"
=======
resource "null_resource" "local_node" {
=======
provider "local" {}

resource "local_file" "example_file" {
  filename = "${path.module}/example-folder/hello.txt"
  content  = "This is created by Terraform inside a Docker agent!"
}

resource "null_resource" "create_folder" {
>>>>>>> 76e8b33 (Update main.tf)
  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/example-folder"
  }
}
<<<<<<< HEAD

provider "null" {}

resource "null_resource" "create_folder_and_file" {
  provisioner "local-exec" {
    command = <<EOT
    mkdir -p /tmp/myfolder
    echo "Hello, Terraform!" > /tmp/myfolder/myfile.txt
    EOT
  }
}


variable "env" {
  default = "dev"
}

variable "region" {
  default = "local"
>>>>>>> 2051675 (Update main.tf)
}
=======
>>>>>>> 76e8b33 (Update main.tf)
