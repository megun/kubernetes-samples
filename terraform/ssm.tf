resource "random_string" "rds_pass" {
  length = 15
  min_upper = 2
  min_lower = 2
  min_numeric = 2
  min_special = 2
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_string" "rds_wp_pass" {
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

resource "aws_ssm_parameter" "rds_endpoint" {
  name        = "/rds/endpoint"
  description = "The parameter description"
  type        = "String"
  value       = aws_rds_cluster.default.endpoint
}

resource "aws_ssm_parameter" "rds_wp_dbname" {
  name        = "/rds/wp/dbname"
  description = "The parameter description"
  type        = "String"
  value       = "wordpress"
}

resource "aws_ssm_parameter" "rds_wp_user" {
  name        = "/rds/wp/user"
  description = "The parameter description"
  type        = "String"
  value       = "wordpress"
}

resource "aws_ssm_parameter" "rds_wp_pass" {
  name        = "/rds/wp/pass"
  description = "The parameter description"
  type        = "SecureString"
  value       = random_string.rds_pass.result
}
