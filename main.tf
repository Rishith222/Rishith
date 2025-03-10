terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

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
  restart = "always"
  must_run = true
  
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
lifecycle {
     prevent_destroy = false
    replace_triggered_by = [self.image_id]
 }

}

