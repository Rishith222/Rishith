terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = var.github_token  # Use a personal access token (PAT) with repo access
}

variable "github_token" {}

variable "repo_name" {
  default = "Rishith222"
}

resource "github_repository_file" "example_file" {
  repository          = var.repo_name
  branch             = "master"
  file               = "my_folder/example.txt"
  content            = "This is a sample file created by Terraform."
  commit_message     = "Added example.txt via Terraform"
}
