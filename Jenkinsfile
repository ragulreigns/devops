pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Dynamically select the branch based on the event trigger
                    def branchName = env.GIT_BRANCH.replaceAll("origin/", "")
                    git credentialsId: 'github-credentials', branch: branchName, url: 'https://github.com/ragulreigns/devops.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Dynamically choose the image tag based on the branch name
                    def branchName = env.GIT_BRANCH.replaceAll("origin/", "")
                    if (branchName == 'dev') {
                        // Build image for the dev branch
                        docker.build("ragul11/dev:latest")
                    } else if (branchName == 'master') {
                        // Build image for the master branch (prod)
                        docker.build("ragul11/prod:latest")
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    def branchName = env.GIT_BRANCH.replaceAll("origin/", "")
                    // Use credentials to login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                            if (branchName == 'dev') {
                                // Push to the dev repository on Docker Hub if the branch is 'dev'
                                docker.image("ragul11/dev:latest").push()
                            } else if (branchName == 'master') {
                                // Push to the prod repository on Docker Hub if the branch is 'master'
                                docker.image("ragul11/prod:latest").push()
                            }
                        }
                    }
                }
            }
        }
    }
}
