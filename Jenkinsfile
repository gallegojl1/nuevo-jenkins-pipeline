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

        stage('login to dockerhub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        
         stage('push image') {
            steps {
                sh 'docker push $IMAGE_NAME:$TAG'
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
