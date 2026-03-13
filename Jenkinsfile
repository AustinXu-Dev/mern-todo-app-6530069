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
                git credentialsId: 'github-cred', branch: 'main', url: 'https://github.com/AustinXu-Dev/mern-todo-app-6530069.git'
            }
        }

        stage('Build') {
            steps {
                dir('TODO/todo_frontend') {
                    sh 'npm install'
                }
                dir('TODO/todo_backend') {
                    sh 'npm install'
                }
            }
        }

        stage('Containerise') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Push') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
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
