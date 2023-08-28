#!/bin/bash

# Function to run Terraform
Run_Terraform() {
    echo "Running Terraform..."
    
    # Change directory to the Terraform project directory
    cd /path/to/terraform/directory
    
    # Initialize Terraform
    terraform init
    
    # Apply Terraform configurations with auto-approval
    terraform apply -auto-approve
    
    # Retrieve the Jenkins server's public IP from Terraform output
    jenkins_ip=$(terraform output Public-ip-jenkins)
    
    # Change back to the original directory
    cd -
    
    echo "Terraform Completed"
}

# Function to update inventory for Ansible
Update_Inventory() {
    echo "Updating Ansible inventory..."
    
    # Path to the Ansible inventory file
    inventory_file="/path/to/ansible/inventory.txt"

    # Update the inventory file with the Jenkins server's IP and connection details
    echo -e "jenkins ansible_host=${jenkins_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/path/to/private/key.pem" > "${inventory_file}"

    echo "Ansible inventory updated"
}

# Function to run Ansible playbook
Run_Ansible() {
    echo "Running Ansible..."
    
    # Change directory to the Ansible project directory
    cd /path/to/ansible/directory
    
    # Disable Ansible host key checking for automation
    export ANSIBLE_HOST_KEY_CHECKING=False
    
    # Run Ansible playbook using the updated inventory file
    ansible-playbook -i inventory.txt playbook.yml
    
    # Change back to the original directory
    cd -
    
    echo "Ansible Completed"
}

# Main script starts here
echo "Starting the automation script..."

# Execute Terraform automation
Run_Terraform
echo "Terraform finished successfully"

# Update Ansible inventory with Jenkins server details
Update_Inventory
echo "Inventory updated successfully"

# Pause for a short duration
sleep 5

# Execute Ansible automation
Run_Ansible
echo "Ansible finished successfully"

echo "Mission Respected"
