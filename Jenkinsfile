pipeline {
    agent any

    environment {
        ECR_REPOSITORY = '263587492988.dkr.ecr.us-east-1.amazonaws.com/ecr-ecr'
        APP_IMAGE_NAME = 'flaskapp'
        DB_IMAGE_NAME = 'mysql'
        APP_PATH = 'Docker/FlaskApp/Dockerfile'
        DB_PATH = 'Docker/MySQL_Queries/Dockerfile'
        DEPLOYMENT_PATH = 'Kubernetes/deploy.yaml'
        STATEFULSET_PATH = 'Kubernetes/mysql-statefulset.yaml'
        AWS_CREDENTIALS_ID = 'aws'
        KUBECONFIG_ID = 'kubeconfig'
    }

    stages {
        stage('Build Images') {
            steps {
                // Build and tag images
                sh "docker build -t ${ECR_REPOSITORY}:${APP_IMAGE_NAME}-${BUILD_NUMBER} -f ${APP_PATH} ."
                sh "docker build -t ${ECR_REPOSITORY}:${DB_IMAGE_NAME}-${BUILD_NUMBER} -f ${DB_PATH} ."
            }
        }

        stage('Push Images') {
            steps {
                withAWS(credentials: "${AWS_CREDENTIALS_ID}") {
                    sh "(aws ecr get-login-password --region us-east-1) | docker login -u AWS --password-stdin ${ECR_REPOSITORY}"
                    sh "docker push ${ECR_REPOSITORY}:${APP_IMAGE_NAME}-${BUILD_NUMBER}"
                    sh "docker push ${ECR_REPOSITORY}:${DB_IMAGE_NAME}-${BUILD_NUMBER}"
                }
            }
        }

        stage('Remove Images') {
            steps {
                // Delete images from Jenkins server
                sh "docker rmi ${ECR_REPOSITORY}:${APP_IMAGE_NAME}-${BUILD_NUMBER}"
                sh "docker rmi ${ECR_REPOSITORY}:${DB_IMAGE_NAME}-${BUILD_NUMBER}"
            }
        }

        stage('Deploy k8s Manifests') {
            steps {
                // Update images in deployment & statefulset manifests with ECR new images
                sh "sed -i 's|image:.*|image: ${ECR_REPOSITORY}:${APP_IMAGE_NAME}-${BUILD_NUMBER}|g' ${DEPLOYMENT_PATH}"
                sh "sed -i 's|image:.*|image: ${ECR_REPOSITORY}:${DB_IMAGE_NAME}-${BUILD_NUMBER}|g' ${STATEFULSET_PATH}"
                
                // Deploy Kubernetes manifests in EKS cluster
                withAWS(credentials: "${AWS_CREDENTIALS_ID}") {
                    withCredentials([file(credentialsId: "${KUBECONFIG_ID}", variable: 'KUBECONFIG')]) {
                        sh "kubectl apply -f Kubernetes" // 'Kubernetes' is a directory containing all Kubernetes manifests
                    }
                }
            }
        }

        stage('Website URL') {
            steps {
                script {
                    withAWS(credentials: "${AWS_CREDENTIALS_ID}") {
                        withCredentials([file(credentialsId: "${KUBECONFIG_ID}", variable: 'KUBECONFIG')]) {
                            def url = sh(script: 'kubectl get svc flask-app-service -o jsonpath="{.status.loadBalancer.ingress[0].hostname}"', returnStdout: true).trim()
                            echo "Website url: http://${url}/"
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline succeeded"
        }
        failure {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline failed"
        }
    }
}
