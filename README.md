# Automated DevOps Capstone Project

## Introduction
This project focuses on automating the deployment of a Flask web application and MySQL database using Docker containers. The deployment process is streamlined by leveraging a combination of Terraform for infrastructure provisioning, Ansible for server configuration, and Jenkins for continuous integration and deployment (CI/CD), all orchestrated by Kubernetes for container management.

## Tools at Your Disposal

- GIT
- Docker
- Kubernetes
- Terraform
- AWS 
- Ansible
- Jenkins

---
## Project Organization

The project is divided into distinct phases, each catering to a specific facet of the infrastructure:

- **Containerization**: Crafting Dockerfiles for the Flask app and MySQL database, complemented by a Docker Compose file for local trial.
- **Terraform Enactment**: Defining integral infrastructure elements like VPC, subnets, EC2 instance, ECR repository, EKS cluster, and more.
- **Ansible Automation**: Facilitating the configuration of the EC2 instance by installing Jenkins, AWS CLI, kubectl, and Docker.
- **Kubernetes Proficiency**: Developing Kubernetes manifests to deploy the Flask app and MySQL database on the EKS cluster.
- **Jenkins Pipeline Mastery**: Setting up a Jenkins pipeline to automate build, push, and deployment activities.

## Step-by-Step Walkthrough

### 1. Getting Hold of the Flask App and MySQL Database

Clone the Flask app and MySQL database repository:
```bash
git clone https://github.com/uym2/MySQL-and-Python.git
```

### 2. Containerizing the App and Database

Navigate to the Docker directory:
```bash
cd Docker
```

Build Docker images and run containers:
```bash
docker-compose up --build
```

### 3. Constructing AWS Infrastructure with Terraform

Navigate to the Terraform directory:
```bash
cd Terraform
```

Initialize Terraform:
```bash
terraform init
```

Apply Terraform configurations:
```bash
terraform apply
```

### 4. Configuring EC2 Instance via Ansible

Navigate to the Ansible directory:
```bash
cd Ansible
```

Run Ansible playbook for EC2 configuration:
```bash
ansible-playbook setup.yml
```

### 5. Constructing Kubernetes Manifests

Navigate to the Kubernetes directory:
```bash
cd Kubernetes
```

Apply Kubernetes manifests:
```bash
kubectl apply -f .
```

### 6. Orchestrating Jenkins Pipeline

Navigate to the Jenkins directory:
```bash
cd Jenkins
```

Follow the guide to set up the Jenkins pipeline.

---
## In Conclusion

#### This comprehensive DevOps infrastructure deployment endeavor underscores the amalgamation of diverse tools and technologies, culminating in a seamless end-to-end deployment procedure. By following the structured guide, you have effectively established a sturdy pipeline for constructing, deploying, and managing a Flask web application and MySQL database on AWS with Kubernetes. This undertaking establishes a robust basis for refining and enhancing your DevOps practices.

#### You're encouraged to further explore and optimize each component, tailoring the project to your unique requirements. Here's to successful deployments!
```

Feel free to use this content in your GitHub repository's README, making any necessary adjustments to fit your project's details.
