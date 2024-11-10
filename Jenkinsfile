pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    
                    def branchName = env.GIT_BRANCH.replaceAll("origin/", "")
                    
                    git credentialsId: 'github-credentials', branch: branchName, url: 'https://github.com/ragulreigns/devops.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Get the branch name dynamically
                    def branchName = env.GIT_BRANCH.replaceAll("origin/", "")
                    // Build the Docker image depending on the branch
                    if (branchName == 'dev') {
                        docker.build("ragul11/devops-build:dev")
                    } else if (branchName == 'master') {
                        docker.build("ragul11/devops-build:prod")
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        // Get the branch name dynamically
                        def branchName = env.GIT_BRANCH.replaceAll("origin/", "")
                        // Log in to Docker Hub and push the image based on the branch
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                            if (branchName == 'dev') {
                                docker.image("ragul11/devops-build:dev").push()
                            } else if (branchName == 'master') {
                                docker.image("ragul11/devops-build:prod").push()
                            }
                        }
                    }
                }
            }
        }
    }
}
