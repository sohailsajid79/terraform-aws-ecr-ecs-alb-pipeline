data "aws_route53_zone" "lab_zone" {
  name         = "sajid023.co.uk"  
  private_zone = false             
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.rock_paper_scissors_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.lab_zone.zone_id 
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.value]
}

resource "aws_route53_record" "tm_record" {
  zone_id = data.aws_route53_zone.lab_zone.zone_id    
  name    = "app.sajid023.co.uk"                      
  type    = "CNAME"                                   
  ttl     = 300                                       
  records = [aws_lb.rock_paper_scissors_alb.dns_name] 
}
