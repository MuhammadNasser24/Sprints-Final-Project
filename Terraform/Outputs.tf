
output "jenkins-public-ip" {

  value = aws_instance.jenkins-instance.public_ip
}

output "jenkins-public-dns" {

  value = aws_instance.jenkins-instance.public_dns

}

output "ecr-repository-name" {

  value = aws_ecr_repository.ecr.name

}

output "ecr-repository-url" {

  value = aws_ecr_repository.ecr.repository_url

}