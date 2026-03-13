pipeline {
    agent any

    tools {
        nodejs 'NodeJS'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-cred')
        IMAGE_NAME = "${DOCKERHUB_CREDENTIALS_USR}/finead-todo-app"
    }

    stages {

        stage('Checkout Github') {
            steps {
                git credentialsId: 'github-cred', url: 'https://github.com/AustinXu-Dev/mern-todo-app-6530069.git'
            }
        }

        stage('Install Node Dependencies') {
            steps {
                dir('TODO/todo_backend') {
                    sh 'npm install'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
            }
        }
        stage('Push Docker Image') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh "docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                sh "docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest"
                sh "docker push ${IMAGE_NAME}:latest"
            }
        }
    }

    post {
        success {
            echo 'Build successful!'
        }
        failure {
            echo 'Build failed. Please check the logs for details.'
        }
    }
}