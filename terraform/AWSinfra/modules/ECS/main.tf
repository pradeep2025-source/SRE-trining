resource "aws_ecs_cluster" "main" {
  name = "ecs-${var.env}"
}
