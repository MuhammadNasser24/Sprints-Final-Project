pipeline {
    agent any
    environment {
        // Define paths and tags for Docker images
        docker_file_app = 'Docker/FlaskApp/Dockerfile'
        docker_file_db = 'Docker/MySQL_Queries/Dockerfile'
        ecr_repository = '263587492988.dkr.ecr.us-east-1.amazonaws.com/ecr-ecr'
        imageTagApp = "build-${BUILD_NUMBER}-app"
        imageNameapp = "${ecr_repository}:${imageTagApp}"
        imageTagDb = "build-${BUILD_NUMBER}-db"
        imageNameDB = "${ecr_repository}:${imageTagDb}"
        KubernetesFilePath = 'Kubernetes'
        kubeconfigCred = 'config'
    }

    stages {
        stage('Build Docker image for app.py and push it to ECR') {
            steps {
                withCredentials([
                    string(credentialsId: 'AczKey', variable: 'AKIAT2XYJ6R6HU5AXDNI'),
                    string(credentialsId: 'ScrtKey', variable: 'In61NaT99xyhSt8v3o3nllWoa2RPhWQpOntTA2I5')
                ]) {
                    script {
                        // Authenticate with AWS ECR to push Docker image
                        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ecr_repository}"

                        // Build Docker image for app.py
                        sh "docker build -t ${imageNameapp} -f ${docker_file_app} ."

                        // Tag the app Docker image with a version tag
                        sh "docker tag ${imageNameapp} ${ecr_repository}:${imageTagApp}"

                        // Push the app Docker image to ECR
                        sh "docker push ${ecr_repository}:${imageTagApp}"

                        // Remove the locally built app Docker image
                        sh "docker rmi ${ecr_repository}:${imageTagApp}"
                    }
                }
            }
        }

        stage('Install NGINX Ingress Controller') {
            steps {
                script {
                    // Apply NGINX Ingress Controller manifests
                    sh "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud/deploy.yaml"

                    // Wait for the NGINX Ingress Controller to be ready
                    sh "kubectl wait --namespace=ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=180s"
                }
            }
        }

        stage('Apply Kubernetes files') {
            steps {
                withCredentials([
                    string(credentialsId: 'AczKey', variable: 'AKIAT2XYJ6R6HU5AXDNI'),
                    string(credentialsId: 'ScrtKey', variable: 'In61NaT99xyhSt8v3o3nllWoa2RPhWQpOntTA2I5')
                ]) {
                    script {
                        withCredentials([file(credentialsId: kubeconfigCred, variable: 'KUBECONFIG')]) {
                            sh "kubectl --kubeconfig=$KUBECONFIG apply -f ${KubernetesFilePath}"
                            // Updating kubeConfig file 
                            sh "aws eks --region us-east-1 update-kubeconfig --name Project-eks"
                            sh "cat $KUBECONFIG" 

                            

                            // Replace the placeholder with the actual Docker image in the Kubernetes YAML files
                            sh "sed -i 's|image:.*|image: ${imageNameapp}|g' Kubernetes/deployment.yaml"
                            sh "sed -i 's|image:.*|image: ${imageNameDB}|g' Kubernetes/statfulset.yaml"

                            // Apply the modified Kubernetes files
                            sh "kubectl apply --kubeconfig=${KUBECONFIG} -f ${KubernetesFilePath}"

                            
                        }
                    }
                }
            }
        }


        stage('Retrieve DNS') {
            steps {
                script {
                    // Retrieve the DNS from Kubernetes Service using kubectl
                    def dns = sh(script: 'kubectl get svc flask-app-service -o jsonpath="{.status.loadBalancer.ingress[0].hostname}"', returnStdout: true).trim()

                    // Display the URL to the website
                    def websiteUrl = "http://${dns}/"
                    echo "Website URL: ${websiteUrl}"
                }
            }
        }
    }
}
