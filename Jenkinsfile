pipeline {
    agent any

    tools {
        maven 'Maven 3.8.8'  // Must match Maven name in Jenkins
    }

    environment {
        IMAGE_NAME = 'jpmbarros/my-maven-docker-app'
        IMAGE_TAG = "build-${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'DOCKER_TOKEN')]) {
                    sh '''
                        echo $DOCKER_TOKEN | docker login -u jpmbarros --password-stdin
                        docker push $IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build and push complete: $IMAGE_NAME:$IMAGE_TAG"
        }
        failure {
            echo "❌ Build failed"
        }
    }
}
