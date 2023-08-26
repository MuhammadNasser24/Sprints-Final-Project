pipeline {
    agent any
    
    environment {
        FLASK_APP_DOCKERFILE = 'Docker/FlaskApp/Dockerfile'
        FLASK_APP_DB_DOCKERFILE = 'Docker/MySQL_Queries/Dockerfile'
        ECR_REPOSITORY = '263587492988.dkr.ecr.us-east-1.amazonaws.com/ecr-ecr'
        K8S_DEPLOYMENT_FILE = 'Kubernetes/deploy.yaml'
        K8S_STATEFULSET_FILE = 'Kubernetes/mysql-statefulset.yaml'
        EKS_CLUSTER_NAME = 'Project-eks'
        AWS_CREDENTIALS_ID = 'GitCredinstials'
        KUBECONFIG_ID = 'kubeconfig'
        AWS_REGION = 'us-east-1'
        FLASK_IMAGE_NAME = 'flaskapp'
        DB_IMAGE_NAME = 'mysql'
    }

    stages {
        stage('Build and Push Images to ECR') {
            steps {
                script {
                    // Build and push Flask App Docker image to ECR
                    def appDockerfilePath = "${env.WORKSPACE}/${FLASK_APP_DOCKERFILE}"
                    sh "docker build -t ${ECR_REPOSITORY}:${FLASK_IMAGE_NAME}-${BUILD_NUMBER} -f ${appDockerfilePath} ${env.WORKSPACE}"
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPOSITORY}"
                    sh "docker push ${ECR_REPOSITORY}:${FLASK_IMAGE_NAME}-${BUILD_NUMBER}"
                    
                    // Build and push Flask App DB Docker image to ECR
                    def dbDockerfilePath = "${env.WORKSPACE}/${FLASK_APP_DB_DOCKERFILE}"
                    sh "docker build -t ${ECR_REPOSITORY}:${DB_IMAGE_NAME}-${BUILD_NUMBER} -f ${dbDockerfilePath} ${env.WORKSPACE}"
                    sh "docker push ${ECR_REPOSITORY}:${DB_IMAGE_NAME}-${BUILD_NUMBER}"
                }
            }
        }
        
        stage('Update Kubernetes Manifests') {
            steps {
                // updating images in deployment  manifists with ECR new images
                
                sh "sed -i 's|image:.*|image: ${ECR_REPOSITORY}:${FLASK_IMAGE_NAME}-${BUILD_NUMBER}|g' ${K8S_DEPLOYMENT_FILE}"
                
                // updating images in statefulset manifists with ECR new images 
                sh "sed -i 's|image:.*|image: ${ECR_REPOSITORY}:${DB_IMAGE_NAME}-${BUILD_NUMBER}|g' ${K8S_STATEFULSET_FILE}"

                withAWS(credentials: "${AWS_CREDENTIALS_ID}"){
                    withCredentials([file(credentialsId: "${KUBECONFIG_ID}", variable: 'KUBECONFIG')]) {
                        sh "kubectl apply -f Kubernetes"
                
            }
        }
        
        stage('Deploy to EKS') {
            steps {
                // Authenticate with EKS cluster
                sh "aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME}"
                
                // Apply the updated Kubernetes manifests
                sh "kubectl apply -f ${K8S_DEPLOYMENT_FILE}"
                sh "kubectl apply -f ${K8S_STATEFULSET_FILE}"
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
}
    }
