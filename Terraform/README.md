# Using Terraform for Infrastructure Provisioning

This project demonstrates the usage of Terraform to provision infrastructure components including an Amazon EKS cluster, an EC2 instance for Jenkins, and an Amazon ECR repository.

## Prerequisites

Before you begin, make sure you have the following prerequisites:

- An AWS account with appropriate permissions
- Terraform installed on your local machine

## Instructions

To run this project, follow these steps:

1. **Clone the repository:**

   ```sh
   git clone https://github.com/MuhammadNasser24/Sprints-FinalProject.git
   ```

   ### Navigate to the Terraform directory:
   ```sh

   cd Sprints-FinalProject/Terraform
   ```

   ## Open Your Terminal on the Terraform directory path/located:

   ### Run the following Commands:

   ```sh
   sudo terraform init
   sudo terraform apply
   ```

## Clean Up

Remember to clean up your resources when you're done using them:

1. For each module (EKS cluster, EC2 instance, ECR repository), navigate to the respective directory and run:

   ```sh
   terraform destroy
   ```

## Additional Notes

- Make sure you have configured your AWS credentials before running Terraform commands.
- This project is my final project, not an example. Review configurations before deploying in production.
