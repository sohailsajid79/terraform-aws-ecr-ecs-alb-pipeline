# resource "aws_acm_certificate" "rock_paper_scissors_cert" {
#   domain_name       = "*.sajid023.co.uk"
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_acm_certificate_validation" "rock_paper_scissors_cert_validation" {
#   certificate_arn = aws_acm_certificate.rock_paper_scissors_cert.arn

#   validation_record_fqdns = [
#     for record in aws_route53_record.cert_validation : record.fqdn
#   ]

#   depends_on = [aws_route53_record.cert_validation]
# }

# output "cert_domain_validation_options" {
#   value = aws_acm_certificate.rock_paper_scissors_cert.domain_validation_options
# }
