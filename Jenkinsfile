pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository and checkout the branch that triggered the pipeline
                git 'https://github.com/ragulreigns/devops.git'
                script {
                    // Ensure the correct branch is checked out
                    def branch = env.GIT_BRANCH ?: 'dev'  // Default to 'dev' if not set
                    sh "git checkout ${branch}"
                }
            }
        }

        stage('Set Permissions') {
            steps {
                // Ensure that build.sh and deploy.sh have execute permissions
                sh 'chmod +x build.sh deploy.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the build script
                script {
                    def branch = env.GIT_BRANCH ?: 'dev'
                    sh "./build.sh ${branch}"
                }
            }
        }

        stage('Push Docker Image to Docker Hub (Dev)') {
            when {
                branch 'dev'  // Trigger only if the branch is 'dev'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    // Push the image to the dev repository
                    sh './deploy.sh dev'
                }
            }
        }

        stage('Push Docker Image to Docker Hub (Prod)') {
            when {
                branch 'master'  // Trigger only if the branch is 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    // Push the image to the prod repository
                    sh './deploy.sh prod'
                }
            }
        }
    }

    post {
        always {
            // Clean up local Docker image after the build
            sh 'docker rmi project || true'
        }
    }
}
