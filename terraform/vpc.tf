###############################################################################
### create vpc
###############################################################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"
  azs = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]

  public_subnets = var.public_subnets
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"
  }

  private_subnets = var.private_subnets
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }

  enable_nat_gateway = true
  enable_vpn_gateway = false

  vpc_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }

  tags = {
    Terraform = "true"
    Environment = "test"
  }
}
