### eks worker node
resource "aws_security_group" "eks_worker_node" {
  name        = "eks_worker_node"
  description = "Security group for eks worker node"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "eks_worker_node"
    #"kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
  }
}

resource "aws_security_group_rule" "eks_worker_node_egress" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.eks_worker_node.id
}

resource "aws_security_group_rule" "eks_worker_node_ingress_self" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  self            = true

  security_group_id = aws_security_group.eks_worker_node.id
}

resource "aws_security_group_rule" "eks_worker_node_ingress_alb" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"

  source_security_group_id = aws_security_group.alb.id

  security_group_id = aws_security_group.eks_worker_node.id
}

### db
resource "aws_security_group" "db" {
  name        = "db"
  description = "Security group for db"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "db"
  }
}

resource "aws_security_group_rule" "db-from-worker_node" {
  type            = "ingress"
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"

  source_security_group_id = aws_security_group.eks_worker_node.id

  security_group_id = aws_security_group.db.id
}

resource "aws_security_group_rule" "db_egress" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.db.id
}

### alb
resource "aws_security_group" "alb" {
  name        = "alb"
  description = "Security group for alb"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "alb"
  }
}

resource "aws_security_group_rule" "alb-from-allowip-443" {
  type            = "ingress"
  from_port       = 443
  to_port         = 443
  protocol        = "tcp"

  cidr_blocks = [
    "153.227.129.90/32",
  ]

  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "alb-from-allowip-80" {
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"

  cidr_blocks = [
    "153.227.129.90/32",
  ]

  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "alb_egress" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.alb.id
}