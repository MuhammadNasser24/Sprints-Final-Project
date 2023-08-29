#  Ansible <svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="100" height="100" viewBox="0 0 48 48">
<path fill="#424242" d="M44,24c0,11.045-8.955,20-20,20S4,35.045,4,24S12.955,4,24,4S44,12.955,44,24z"></path><path fill="#fff" d="M24.848,12.125c-0.765-0.327-1.651,0.022-1.976,0.784L14.031,33.5c-0.102,0.236,0.072,0.5,0.329,0.5	h2.226c0.3,0,0.571-0.179,0.689-0.454l3.69-8.595l10.581,8.707C31.823,33.886,32.161,34,32.5,34c0.317,0,0.635-0.101,0.903-0.302	c0.553-0.418,0.749-1.16,0.473-1.796l-8.25-19C25.469,12.539,25.185,12.271,24.848,12.125z M22.198,22.08l2.059-4.796l4.385,10.1	L22.198,22.08z"></path>
</svg>
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
