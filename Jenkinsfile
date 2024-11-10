pipeline {
    agent any

    environment {
        IMAGE_NAME = 'ragul11/dev:latest'
        PROD_IMAGE_NAME = 'ragul11/prod:latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-credentials', branch: 'master', url: 'https://github.com/ragulreigns/devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def branch = env.GIT_BRANCH.split('/').last()
                    if (branch == 'dev') {
                        docker.build(IMAGE_NAME)
                    } else if (branch == 'master') {
                        docker.build(PROD_IMAGE_NAME)
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                            def branch = env.GIT_BRANCH.split('/').last()
                            if (branch == 'dev') {
                                docker.image(IMAGE_NAME).push()
                            } else if (branch == 'master') {
                                docker.image(PROD_IMAGE_NAME).push()
                            }
                        }
                    }
                }
            }
        }
    }
}
