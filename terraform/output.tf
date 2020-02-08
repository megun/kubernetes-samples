# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = ["${module.vpc.private_subnets}"]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = ["${module.vpc.public_subnets}"]
}

# ACM ARN
output "acm_arn" {
  description = "ARN of acm"
  value       = aws_acm_certificate.cert.arn
}

# SecurityGroup of ALB
output "securitygroup_alb" {
  description = "SecurityGroup of ALB"
  value       = aws_security_group.alb.id
}
