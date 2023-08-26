# Create an ECR repository 
resource "aws_ecr_repository" "ecr" {
  name                 = "ecr-ecr"
  image_tag_mutability = "MUTABLE" # Allow tags to be changed

  # Configure image scanning for the repository

  image_scanning_configuration {
    scan_on_push = true # Enable automatic scanning of images on push
  }
}