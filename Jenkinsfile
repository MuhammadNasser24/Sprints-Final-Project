pipeline {
    agent any
    environment {
        docker_file_app = 'Docker/FlaskApp/Dockerfile'
        docker_file_db = 'Docker/MySQL_Queries/Dockerfile'
        ecr_repository = '263587492988.dkr.ecr.us-east-1.amazonaws.com/ecr-ecr'
        imageTagApp = "build-${BUILD_NUMBER}-app"
        imageNameapp = "${ecr_repository}:${imageTagApp}"
        imageTagDb = "build-${BUILD_NUMBER}-db"
        imageNameDB = "${ecr_repository}:${imageTagDb}"
        KubernetesFilePath = 'Kubernetes'
    }

    stages {
        stage('Build Docker image for app.py and push it to ECR') {
            steps {
                withCredentials([
                    string(credentialsId: 'AczKey', variable: 'AKIAT2XYJ6R6HU5AXDNI'),
                    string(credentialsId: 'ScrtKey', variable: 'In61NaT99xyhSt8v3o3nllWoa2RPhWQpOntTA2I5')
                ]) {
                    script {
                        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ecr_repository}"
                        sh "docker build -t ${imageNameapp} -f ${docker_file_app} ."
                        sh "docker tag ${imageNameapp} ${ecr_repository}:${imageTagApp}"
                        sh "docker push ${ecr_repository}:${imageTagApp}"
                        sh "docker rmi ${ecr_repository}:${imageTagApp}"
                    }
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
                        def kubeconfigCred = credentials('config')
                        withCredentials([file(credentialsId: kubeconfigCred, variable: 'KUBECONFIG')]) {
                            sh "kubectl --kubeconfig=$KUBECONFIG apply -f ${KubernetesFilePath}"
                        }
                        
                        sh "pwd"
                        sh "ls -1 ${KubernetesFilePath}"
                        
                        sh "sed -i 's|image:.*|image: ${imageNameapp}|g' ${KubernetesFilePath}/deployment.yaml"
                        sh "sed -i 's|image:.*|image: ${imageNameDB}|g' ${KubernetesFilePath}/statfulset.yaml"
                        
                        sh "kubectl apply -f ${KubernetesFilePath}"
                        sh "aws eks --region us-east-1 update-kubeconfig --name Project-eks"
                    }
                }
            }
        }

        stage('Retrieve DNS') {
            steps {
                script {
                    def dns = sh(script: 'kubectl get svc flask-app-service -o jsonpath="{.status.loadBalancer.ingress[0].hostname}"', returnStdout: true).trim()
                    def websiteUrl = "http://${dns}/"
                    echo "Website URL: ${websiteUrl}"
                }
            }
        }
    }
}
