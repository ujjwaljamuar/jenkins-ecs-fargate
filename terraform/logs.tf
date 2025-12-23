# resource "aws_cloudwatch_log_group" "ecs" {
#   name              = "/ecs/${var.project_name}"
#   retention_in_days = 3
# logConfiguration {
#   logDriver = "awslogs"
#   options = {
#     awslogs-group         = "/ecs/jenkins-on-demand"
#     awslogs-region        = "ap-south-1"
#     awslogs-stream-prefix = "ecs"
#   }
# }
# }


