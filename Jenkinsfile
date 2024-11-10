pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'project'
        DOCKER_REGISTRY = 'docker.io'
        DEV_REPO = 'ragul11/dev'
        PROD_REPO = 'ragul11/prod'
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository with credentials
                git credentialsId: 'github-credentials', url: 'https://github.com/ragulreigns/devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Push Docker Image to Docker Hub (Dev)') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    // Use withCredentials to securely pass Docker Hub credentials
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Docker login to Docker Hub
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'

                        // Tag and push to dev Docker Hub repository
                        sh "docker tag $DOCKER_IMAGE $DOCKER_REGISTRY/$DEV_REPO:latest"
                        sh "docker push $DOCKER_REGISTRY/$DEV_REPO:latest"
                    }
                }
            }
        }

        stage('Push Docker Image to Docker Hub (Prod)') {
            when {
                branch 'master'
            }
            steps {
                script {
                    // Use withCredentials to securely pass Docker Hub credentials
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Docker login to Docker Hub
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'

                        // Tag and push to prod Docker Hub repository
                        sh "docker tag $DOCKER_IMAGE $DOCKER_REGISTRY/$PROD_REPO:latest"
                        sh "docker push $DOCKER_REGISTRY/$PROD_REPO:latest"
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up the Docker images after the build
            sh 'docker rmi $DOCKER_IMAGE || true'
        }
    }
}
