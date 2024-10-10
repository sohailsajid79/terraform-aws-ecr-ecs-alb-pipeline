resource "aws_ecr_repository" "rock_paper_scissors" {
  name                 = "rock-paper-scissors-app"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
}