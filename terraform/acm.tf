resource "aws_acm_certificate" "rock_paper_scissors_cert" {
  domain_name       = "app.sajid023.co.uk"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "rock-paper-scissors-acm-certificate"
  }
}

resource "aws_acm_certificate_validation" "rock_paper_scissors_cert_validation" {
  certificate_arn         = aws_acm_certificate.rock_paper_scissors_cert.arn
  validation_record_fqdns = [for record in cloudflare_record.acm_validation : record.hostname]
}
