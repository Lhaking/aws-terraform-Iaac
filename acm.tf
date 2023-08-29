resource "aws_acm_certificate" "main" {
  domain_name = "uniquesoftuk.com"
  validation_method = "DNS"

  tags = {
    Name = "uniquesoftuk_certificate"

  }
  lifecycle {
    create_before_destroy = true
    
  }

}

data "aws_route53_zone" "main" {
  name         = "uniquesoftuk.com"
  private_zone = false
}

resource "aws_route53_record" "main" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name      = dvo.resource_record_name
      record    = dvo.resource_record_value
      type      = dvo.resource_record_type
      zone_id   = data.aws_route53_zone.main.zone_id

    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.main : record.fqdn]
}

resource "aws_route53_record" "main2" {
  zone_id = data.aws_route53_zone.main.zone_id
  name = "www.uniquesoftuk.com"
  type = "A"

  alias {
    name = aws_lb.main.dns_name
    zone_id = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}


           
# module "s3_buckets" {
#   source = "terraform-aws-modules/s3-bucket/aws"
#   count  = 3

#   bucket = "lkg-bucket-${count.index}"
#   acl    = "private"

#   control_object_ownership = true
#   object_ownership         = "ObjectWriter"

#   versioning = {
#     enabled = true
#   }
# }





  
