# Creating the main internet gateway for the Capstone-Project
resource "aws_internet_gateway" "project-igw" {
  vpc_id = aws_vpc.vpc-project.id


  tags = {
    Name = "Project-InternetGateway"
  }
}