output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.rock_paper_scissors.repository_url
}

output "alb_dns_name" {
  value       = aws_lb.rock_paper_scissors_alb.dns_name
  description = "The DNS name of the ALB to access the application"
}