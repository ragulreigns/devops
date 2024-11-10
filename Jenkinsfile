pipeline {
    agent any

    environment {
        DOCKER_USERNAME = credentials('dockerhub-username')
        DOCKER_PASSWORD = credentials('dockerhub-password')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/ragulreigns/devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Use the build.sh script
                sh './build.sh dev'
            }
        }

        stage('Push Docker Image to Docker Hub (Dev)') {
            when {
                branch 'dev'
            }
            steps {
                // Use the deploy.sh script to push to dev repo
                sh './deploy.sh dev'
            }
        }

        stage('Push Docker Image to Docker Hub (Prod)') {
            when {
                branch 'master'
            }
            steps {
                // Use the deploy.sh script to push to prod repo
                sh './deploy.sh prod'
            }
        }
    }

    post {
        always {
            sh 'docker rmi project || true'
        }
    }
}
