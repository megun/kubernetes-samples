resource "aws_route53_zone" "private" {
  name = "private"

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}

resource "aws_route53_record" "db" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "auroa-serverless"
  type    = "A"

  alias {
    name                   = aws_rds_cluster.default.endpoint
    zone_id                = aws_rds_cluster.default.hosted_zone_id
    evaluate_target_health = true
  }
}
