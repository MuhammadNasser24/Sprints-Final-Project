# Create a VPC
resource "aws_vpc" "vpc-project" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "poject-vpc"
  }
}
