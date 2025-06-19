pipeline {
    agent any

    environment {
        IMAGE_NAME = 'gallegojl1/mi-app'
        TAG = 'latest'
        DOCKERHUB_CREDENTIALS = credentials('joseluis-dockerhub')
    }
    
    stages {
        stage('Check Docker') {
            steps {
                sh 'which docker || echo "Docker no está disponible"'
            }
        }
        
        stage('Checkout') {
            steps {
                git url: 'https://github.com/gallegojl1/nuevo-jenkins-pipeline.git' , branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$TAG .'
            }
        }
        stage('Run App Container') {
              steps {
                sh 'docker run -d -p 3001:3001 --name mi-app gallegojl1/mi-app'
              }
        }
        
    }

    post {
        success {
            echo '✅ Imagen Docker construida y publicada con éxito.'
        }
        failure {
            echo '❌ Error en la construcción o subida de la imagen.'
        }
    }
}
