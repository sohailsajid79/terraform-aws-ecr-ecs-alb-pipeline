data "cloudflare_zone" "sajid023_zone" {
  name = "sajid023.co.uk"
}

resource "cloudflare_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.rock_paper_scissors_cert.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = data.cloudflare_zone.sajid023_zone.id
  name    = each.value.name
  value   = each.value.value
  type    = each.value.type
  ttl     = 60
}

resource "cloudflare_record" "app_subdomain" {
  zone_id = data.cloudflare_zone.sajid023_zone.id
  name    = "app"
  value   = aws_lb.rock_paper_scissors_alb.dns_name
  type    = "CNAME"
  ttl     = 1
  proxied = true
}