
![icons8-kubernetes-480](https://github.com/MuhammadNasser24/Sprints-Final-Project/assets/121057828/f93327e7-b438-4c02-b496-765fc45b96a8)

 ### Kubernetes:
 An open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. It abstracts the underlying infrastructure, allowing you to focus on application logic. Kubernetes ensures high 
availability, load balancing, and self-healing, making it easier to manage and scale applications in dynamic environments.

## Kubernetes Manifests for MySQL and Flask App

This repository contains Kubernetes manifest files for deploying a Flask app and MySQL database in a Kubernetes cluster. The manifest files define services, deployments, config maps, secrets, and more to orchestrate the deployment of the application components.

## Applying Kubernetes Manifests

To deploy the application components to a Kubernetes cluster, follow these steps:

1. Make sure you have `kubectl` installed on your local machine. If you haven't installed it yet, follow the official installation guide for your specific operating system:

   - [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

2. Clone this repository to your local machine:

   ```sh
   git clone https://github.com/MuhammadNasser24/Sprints-FinalProject.git 
   ```

3. Navigate to the repository directory:

   ```sh
   cd https://github.com/MuhammadNasser24/Sprints-FinalProject.git
   ```

4. Apply the Kubernetes manifest files in the correct order using the `kubectl apply` command:

   ```sh
   kubectl apply -f AppService.yaml
   kubectl apply -f ConfigMap.yaml
   kubectl apply -f MySQLService.yaml
   kubectl apply -f deployment.yaml
   kubectl apply -f ingress.yaml
   kubectl apply -f pf.yaml
   kubectl apply -f pvc.yaml
   kubectl apply -f secret.yml
   kubectl apply -f statfulset.yaml
   ```

5. Monitor the status of your resources using `kubectl get` commands, such as `kubectl get pods`, `kubectl get services`, and so on.

## Note on Kubernetes Deployment

Please note that these manifest files are provided as an example and should be tailored to match your specific requirements. Carefully review and customize environment variables, labels, resource specifications, and other settings according to your application's needs.

## External Resources

For more information on Kubernetes and how to work with manifest files, you can refer to the official Kubernetes documentation:

- [Kubernetes Documentation](https://kubernetes.io/docs/)
