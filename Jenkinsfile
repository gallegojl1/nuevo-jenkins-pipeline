pipeline {
    agent any

    environment {
        IMAGE_NAME = 'gallegojl1/mi-app'
        TAG = 'latest'
        DOCKERHUB_CREDENTIALS = credentials('joseluis-dockerhub')
        REMOTE_HOST = '217.160.88.215'
        REMOTE_USER = 'root'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/gallegojl1/nuevo-jenkins-pipeline.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$TAG .'
            }
        }

        stage('Login & Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'joseluis-dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo "$PASS" | docker login -u "$USER" --password-stdin
                        docker push $IMAGE_NAME:$TAG
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                sshagent (credentials: ['servidor-remoto']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST "
                            docker pull $IMAGE_NAME:$TAG &&
                            docker stop mi-app || true &&
                            docker rm mi-app || true &&
                            docker run -d -p 8080:80 --name mi-app $IMAGE_NAME:$TAG

                        "
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deploy completado con éxito.'
        }
        failure {
            echo '❌ Hubo un error en el pipeline.'
        }
    }
}
