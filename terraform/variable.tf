variable "public_subnets" {
  default = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}

variable "private_subnets" {
  default = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
}

variable "eks_cluster_name" {
  default = "cluster-001"
}

variable "eks_cluster_region" {
  default = "ap-northeast-1"
}
