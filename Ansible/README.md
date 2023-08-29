# Ansible 
[!Ansible Logo](https://icons8.com/icon/iGCCE2iEmh2u/ansible)
A powerful open-source automation tool that simplifies complex tasks, configuration management, and application deployment. It uses simple declarative YAML scripts, called playbooks, to define and automate workflows, making it efficient for managing and orchestrating IT infrastructure.
# Ansible Automation for Jenkins Setup

This Ansible playbook automates the installation and configuration of Jenkins on a remote server. It also installs required dependencies such as AWS CLI and Docker.

## Installation

Before you proceed, make sure you have Ansible installed on your local machine. If you haven't installed Ansible yet, follow these steps:

1. Install Ansible using your package manager. For example, on Ubuntu:

   ```sh
   sudo apt update
   sudo apt install ansible
   ```

2. Verify the installation:

   ```sh
   ansible --version
   ```

## Running the Ansible Playbook

To run the Ansible playbook, follow these steps:

1. Clone the repository to your local machine if you haven't already:

   ```sh
   git clone https://github.com/MuhammadNasser24/Sprints-FinalProject.git
   ```

2. Navigate to the Ansible directory:

   ```sh
   cd Sprints-FinalProject/Ansible
   ```

3. Edit the `inventory.txt` file to replace `54.162.215.44` with the actual public IP address of your EC2 instance.

4. Open a terminal and run the following command to execute the Ansible playbook:

   ```sh
   ansible-playbook -i inventory.txt playbook.yaml
   ```

## Ansible Playbook Overview

The `playbook.yaml` file contains a series of tasks that automate the setup of Jenkins and its dependencies. Here's an overview of what the playbook does:

1. Installs required packages, including `unzip`, `ca-certificates`, `curl`, and `apt-transport-https`.
2. Installs the AWS CLI if it's not already installed.
3. Installs `kubectl` for Kubernetes command-line access.
4. Installs Java (OpenJDK 11) and Jenkins.
5. Starts the Jenkins service.
6. Installs Docker and configures permissions for Docker usage.
7. Restarts Docker and Jenkins services.
8. Retrieves the initial Jenkins admin password.

Please note that this is a high-level overview. For detailed information about each task and its purpose, refer to the `playbook.yaml` file in the repository.

> **Note:** This playbook assumes you have SSH access to the remote server and the necessary permissions to perform the described tasks.
