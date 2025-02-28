pipeline {
    agent any
    stages {
        stage('Install Dependencies') {
            steps {
                // Install dependencies from requirements.txt
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Run Tests') {
            steps {
                // Run your test suite
                sh 'pytest'
            }
        }
    }
}
