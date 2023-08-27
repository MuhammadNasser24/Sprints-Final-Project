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
        KubernetesFilePath = 'Sprints-FinalProject/Kubernetes'
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
                        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ecr_repository"

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

        // Other stages for building and pushing the DB image, and deploying Kubernetes manifests...

        stage('Apply Kubernetes files') {
            steps {
                withCredentials([
                    
                    // Credentials setup...
                    string(credentialsId: 'AczKey', variable: 'AKIAT2XYJ6R6HU5AXDNI'),
                    string(credentialsId: 'ScrtKey', variable: 'In61NaT99xyhSt8v3o3nllWoa2RPhWQpOntTA2I5')

                    
                ]) {
                    script {
                        // Replace the placeholder with the actual Docker image in the Kubernetes YAML files...
                        sh "sed -i 's|image:.*|image: ${imageNameapp}|g' Kubernetes/deploy.yaml"
                        sh "sed -i 's|image:.*|image: ${imageNameDB}|g' Kubernetes/mysql-statefulset.yaml"
                        sh "pwd"
                        sh "ls -l"
                        sh "cd Sprints-FinalProject/Kubernetes"

                        sh "aws eks --region us-east-1 update-kubeconfig --name Project-eks"

                        // Navigate to the Kubernetes directory

                        dir("${KubernetesFilePath}") {

                            // Use shell command to apply each YAML file

                            sh "ls -1 *.yaml | xargs -I {} kubectl apply -f {}"
                            
                       
                        }
                    }
                }
            }
        }

        // Other stages...

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
