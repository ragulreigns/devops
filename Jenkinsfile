pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-credentials', branch: 'master', url: 'https://github.com/ragulreigns/devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Building the Docker image
                    docker.build("ragul11/prod:latest")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // Handling credentials properly
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        // Logging in and pushing to Docker Hub
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                            docker.image("ragul11/prod:latest").push()
                        }
                    }
                }
            }
        }
    }
}