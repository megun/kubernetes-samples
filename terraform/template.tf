data "template_file" "eksctl" {
  template = "${file("./template/eksctl_cluster.tpl.yaml")}"
  vars = {
    eks_cluster_name   = var.eks_cluster_name
    eks_cluster_region = var.eks_cluster_region

    private_subnet_id_0 = module.vpc.private_subnets[0]
    private_subnet_id_1 = module.vpc.private_subnets[1]
    private_subnet_id_2 = module.vpc.private_subnets[2]

    public_subnet_id_0 = module.vpc.public_subnets[0]
    public_subnet_id_1 = module.vpc.public_subnets[1]
    public_subnet_id_2 = module.vpc.public_subnets[2]

    worker_node_securitygroups   = aws_security_group.eks_worker_node.id

    instance_profile_arn_worker = aws_iam_instance_profile.eks_worker.arn
    instance_role_arn_worker    = aws_iam_role.eks_worker.arn
  }
} 

resource "local_file" "eksctl" {
  content         = data.template_file.eksctl.rendered
  filename        = "../eksctl/cluster.yaml"
  file_permission = "0666"
}
