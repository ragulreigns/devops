pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-credentials', branch: '*/dev', url: 'https://github.com/ragulreigns/devops.git'
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
                script {
                    def branchName = env.GIT_BRANCH
                    if (branchName == 'origin/dev') {
                        // Push to dev repository if it's the dev branch
                        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                            script {
                                docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                                    docker.image("ragul11/devops-build:prod").push("dev")
                                }
                            }
                        }
                    } else if (branchName == 'origin/master') {
                        // Push to prod repository if it's the master branch
                        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                            script {
                                docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                                    docker.image("ragul11/devops-build:prod").push("prod")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
