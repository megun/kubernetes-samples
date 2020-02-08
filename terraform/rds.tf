resource "random_string" "rds_pass" {
  length = 15
  min_upper = 2
  min_lower = 2
  min_numeric = 2
  min_special = 2
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_ssm_parameter" "rds_pass" {
  name        = "/rds/pass"
  description = "The parameter description"
  type        = "SecureString"
  value       = random_string.rds_pass.result
}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster"
  engine_mode             = "serverless"

  availability_zones      = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  db_subnet_group_name = aws_db_subnet_group.main.id
  vpc_security_group_ids = [aws_security_group.db.id]


  database_name           = "mydb"
  master_username         = "root"
  master_password         = aws_ssm_parameter.rds_pass.value

  skip_final_snapshot  = true
}
