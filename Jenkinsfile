pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/ragulreigns/devops.git'
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
                // Use the build.sh script to build the Docker image
                sh './build.sh dev'
            }
        }

        stage('Push Docker Image to Docker Hub (Dev)') {
            when {
                branch 'dev'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    // Use deploy.sh to push to dev repo
                    sh './deploy.sh dev'
                }
            }
        }

        stage('Push Docker Image to Docker Hub (Prod)') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    // Use deploy.sh to push to prod repo
                    sh './deploy.sh prod'
                }
            }
        }
    }

    post {
        always {
            sh 'docker rmi project || true'
        }
    }
}
