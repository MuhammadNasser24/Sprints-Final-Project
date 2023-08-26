# Creating RouteTable for Capstone-Project
resource "aws_route_table" "RT-project" {
  vpc_id = aws_vpc.vpc-project.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-igw.id # Adding new route on 0.0.0.0/0 with internet gateway to make it Public
  }


  tags = {
    Name = "RoutTable-Project"
  }
}

# Associate the 2 subnets (subnet01,subnet02) to the new rout table 
resource "aws_route_table_association" "rt-Associate-1" {
  subnet_id      = aws_subnet.subnet01.id
  route_table_id = aws_route_table.RT-project.id

}

resource "aws_route_table_association" "rt-Associate-2" {
  subnet_id      = aws_subnet.subnet02.id
  route_table_id = aws_route_table.RT-project.id
}