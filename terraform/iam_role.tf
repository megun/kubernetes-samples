### IAM Role for EKS Worker Node
resource "aws_iam_role" "eks_worker" {
  name = "eks_worker"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "eks_worker" {
  name = "eks_worker"
  path = "/"
  role = aws_iam_role.eks_worker.name
}

locals {
  eks_worker_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
  ]
}

resource "aws_iam_role_policy_attachment" "eks_worker" {
  for_each   = toset(local.eks_worker_policies)
  role       = aws_iam_role.eks_worker.name
  policy_arn = each.key
}
