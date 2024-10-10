resource "aws_ecs_cluster" "rock_paper_scissors_cluster" {
  name = "rock-paper-scissors-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "rock_paper_scissors_task" {
  family                   = "rock-paper-scissors-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "rock-paper-scissors-container"
    image     = "${aws_ecr_repository.rock_paper_scissors.repository_url}:${var.image_tag}"
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
    }]
  }])
}

resource "aws_ecs_service" "rock_paper_scissors_service" {
  name            = "rock-paper-scissors-service"
  cluster         = aws_ecs_cluster.rock_paper_scissors_cluster.id
  task_definition = aws_ecs_task_definition.rock_paper_scissors_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
    security_groups  = [aws_security_group.ecs_service_sg.id] # Using the new SG
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.rock_paper_scissors_tg.arn
    container_name   = "rock-paper-scissors-container"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.http_listener]
}

