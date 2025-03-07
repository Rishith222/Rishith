pipeline {
    agent {
        docker {
            image 'my-jenkins-agent:latest'  // Use the Docker agent with Terraform installed
            args '--user root'  // Run as root to allow file operations
        }
    }

    environment {
        TF_VAR_REGION = 'us-west-2'  // Example Terraform environment variable
    }

    stages {
        stage('Clone Terraform Repo') {
            steps {
                sh 'rm -rf terraform-project && git clone https://github.com/Rishith222/Rishith.git terraform-project'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform-project') {  // Navigate inside the Terraform directory
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform-project') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform-project') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
}
