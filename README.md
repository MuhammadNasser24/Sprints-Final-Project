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

### Containerization

Crafting Dockerfiles for the Flask app and MySQL database, complemented by a Docker Compose file for local trial.

```bash
# Navigate to the Docker directory
cd Docker

# Build Docker images and run containers
docker-compose up --build
