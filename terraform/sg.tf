resource "aws_security_group" "db" {
  name        = "db"
  description = "Security group for db"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "db"
  }
}

resource "aws_security_group_rule" "db-from-private" {
  type            = "ingress"
  from_port       = 0
  to_port         = 3306
  protocol        = "tcp"

  cidr_blocks = [
      "10.0.0.0/8",
  ]

  security_group_id = aws_security_group.db.id
}
