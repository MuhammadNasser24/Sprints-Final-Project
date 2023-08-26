# Creating AWS instance EC2
resource "aws_instance" "jenkins-instance" {
  ami                         = data.aws_ami.latest_ubuntu.image_id
  instance_type               = "t2.medium"
  key_name                    = "Capstone-Project"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet01.id
  vpc_security_group_ids      = [aws_security_group.SG-project.id]
  iam_instance_profile        = aws_iam_instance_profile.worker.name

  tags = {
    Name = "Jenkins-Server"
  }
}
