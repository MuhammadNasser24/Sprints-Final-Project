# Create an Amazon EKS cluster
resource "aws_eks_cluster" "eks" {
  name     = "Project-eks"
  role_arn = aws_iam_role.master.arn


  vpc_config {
    subnet_ids = [aws_subnet.subnet01.id, aws_subnet.subnet02.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    #aws_subnet.subnet01,
    #aws_subnet.subnet02,

  ]
}