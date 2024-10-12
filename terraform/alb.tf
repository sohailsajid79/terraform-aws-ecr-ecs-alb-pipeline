
resource "aws_lb" "rock_paper_scissors_alb" {
  name               = "rock-paper-scissors-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  enable_deletion_protection = false

  tags = {
    Name = "rock-paper-scissors-alb"
  }
}

resource "aws_lb_target_group" "rock_paper_scissors_tg" {
  name        = "rock-paper-scissors-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ecs_vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "rock-paper-scissors-tg"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.rock_paper_scissors_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rock_paper_scissors_tg.arn
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.rock_paper_scissors_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.rock_paper_scissors_cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rock_paper_scissors_tg.arn
  }
}