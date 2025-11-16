pipeline {
    agent any

    environment {
        DOCKERHUB_USER = credentials('dockerhub-user')
        DOCKERHUB_PASS = credentials('dockerhub-pass')
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_REGION = "ap-south-1"
        ECR_REPO = "123456789012.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app"
        APP_NAME = "nodejs-app"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/yourusername/your-nodejs-app.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $APP_NAME ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh """
                    echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
                    docker tag $APP_NAME:latest $DOCKERHUB_USER/$APP_NAME:latest
                    docker push $DOCKERHUB_USER/$APP_NAME:latest
                """
            }
        }

        stage('Push to AWS ECR') {
            steps {
                sh """
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin $ECR_REPO
                    docker tag $APP_NAME:latest $ECR_REPO:latest
                    docker push $ECR_REPO:latest
                """
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh "kubectl apply -f k8s/deployment.yaml"
                sh "kubectl apply -f k8s/service.yaml"
            }
        }
    }
}
