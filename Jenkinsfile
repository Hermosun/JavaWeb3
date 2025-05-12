pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'hermosun/javaweb3'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/CeeyIT-Solutions/JavaWeb3.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project with Maven...'
                script {
                    docker.image('maven:3.8.3-openjdk-11').inside {
                        sh 'mvn clean package'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push()
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push('latest')
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying Docker container...'
                script {
                    sh 'docker run -d -p 8080:8080 ${DOCKER_IMAGE}:${env.BUILD_ID}'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker images...'
            sh 'docker rmi ${DOCKER_IMAGE}:${env.BUILD_ID}'
        }
    }
}
// This Jenkinsfile is a simple CI/CD pipeline for a Java web application using Maven and Docker.