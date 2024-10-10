output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.rock_paper_scissors.repository_url
}

output "ecr_repository_arn" {
  description = "The ARN of the ECR repository"
  value       = aws_ecr_repository.rock_paper_scissors.arn
}

output "alb_dns_name" {
  value       = aws_lb.rock_paper_scissors_alb.dns_name
  description = "The DNS name of the ALB to access the application"
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.ecs_vpc.id
}

output "subnet_public_1_id" {
  description = "ID of the first public subnet"
  value       = aws_subnet.public_subnet_1.id
}

output "subnet_public_2_id" {
  description = "ID of the second public subnet"
  value       = aws_subnet.public_subnet_2.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.ecs_igw.id
}

output "ecs_service_security_group_id" {
  description = "Security group ID for ECS service"
  value       = aws_security_group.ecs_service_sg.id
}

output "alb_security_group_id" {
  description = "Security group ID for ALB"
  value       = aws_security_group.alb_sg.id
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_service_role_arn" {
  description = "ARN of the ECS Service Role"
  value       = aws_iam_role.ecs_service_role.arn
}