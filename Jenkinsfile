pipeline {
    agent any
    
    environment {
        FLASK_APP_DOCKERFILE = "Sprints-FinalProject/Docker/FlaskApp/Dockerfile"
        FLASK_APP_DB_DOCKERFILE = "Sprints-FinalProject/Docker/MySQL_Queries/Dockerfile"
        ECR_REPOSITORY = "263587492988.dkr.ecr.us-east-1.amazonaws.com/ecr-ecr"
        K8S_DEPLOYMENT_FILE = "Sprints-FinalProject/Kubernetes/deploy.yaml"
        K8S_STATEFULSET_FILE = "Sprints-FinalProject/Kubernetes/mysql-statefulset.yaml"
        EKS_CLUSTER_NAME = 'your-eks-cluster-name'
        FLASK_APP_TAG = 'flask-app-latest'
        FLASK_APP_DB_TAG = 'flask-app-db-latest'
        AWS_CREDENTIALS_ID = 'GitCredinstials'
        KUBECONFIG_ID = 'kubeconfig'
    }

    stages {
        stage('Build and Push Images to ECR') {
            steps {
                script {
                    
                    // Build and push Flask App Docker image to ECR
                    sh "docker build -t ${ECR_REPOSITORY}:${FLASK_APP_TAG} -f ${FLASK_APP_DOCKERFILE} ."
                    sh "aws ecr get-login-password --region <aws-region> | docker login --username AWS --password-stdin ${ECR_REPOSITORY}"
                    sh "docker push ${ECR_REPOSITORY}:${FLASK_APP_TAG}"
                    
                    // Build and push Flask App DB Docker image to ECR
                    sh "docker build -t ${ECR_REPOSITORY}:${FLASK_APP_DB_TAG} -f ${FLASK_APP_DB_DOCKERFILE} ."
                    sh "docker push ${ECR_REPOSITORY}:${FLASK_APP_DB_TAG}"
                }
            }
        }
        
        stage('Delete Images from Jenkins Server') {
            steps {
                sh "docker rmi ${ECR_REPOSITORY}:${FLASK_APP_TAG} ${ECR_REPOSITORY}:${FLASK_APP_DB_TAG}"
            }
        }
        
        stage('Update Kubernetes Manifests') {
            steps {
                // Update Kubernetes deployment and statefulset manifests
                sh "sed -i 's|old-image:${FLASK_APP_TAG}|${ECR_REPOSITORY}:${FLASK_APP_TAG}|g' ${K8S_DEPLOYMENT_FILE}"
                sh "sed -i 's|old-image:${FLASK_APP_DB_TAG}|${ECR_REPOSITORY}:${FLASK_APP_DB_TAG}|g' ${K8S_STATEFULSET_FILE}"
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
