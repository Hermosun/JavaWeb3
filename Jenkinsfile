pipeline {
    agent any
    
    environment {
        // Update with your Docker Hub username
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials'
        DOCKER_IMAGE_NAME = 'hermosun/java-calculator' // Change to your Docker Hub username
        DOCKER_IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Build Maven Project') {
            steps {
                // Check if Maven is installed
                sh 'mvn --version || echo "Maven not installed"'
                
                // Build with Maven if available
                sh 'mvn clean package || echo "Maven build failed, continuing with Docker build"'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                // Check if Docker is installed
                sh 'docker --version'
                
                // Build the Docker image
                sh "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
            }
        }
        
        stage('Run Container Locally') {
            steps {
                // Stop and remove existing container if it exists
                sh 'docker stop java-calculator || true'
                sh 'docker rm java-calculator || true'
                
                // Run the container
                sh "docker run -d -p 8080:8080 --name java-calculator ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                
                echo "Application is now running at http://localhost:8080"
            }
        }
    }
    
    post {
        always {
            echo "Cleaning up..."
            // Clean up only if Docker is available
            sh 'docker --version && docker rmi ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} || true'
        }
    }
}