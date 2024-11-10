pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/ragulreigns/devops-build.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("ragul11/devops-build:prod")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-credentials', variable: 'DOCKER_HUB_PASSWORD')]) {
                    script {
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                            docker.image("ragul11/devops-build:prod").push()
                        }
                    }
                }
            }
        }
    }
}
