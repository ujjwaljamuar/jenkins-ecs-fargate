resource "aws_ecs_task_definition" "jenkins" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "2048"

  execution_role_arn = aws_iam_role.ecs_execution.arn
  task_role_arn      = aws_iam_role.ecs_task.arn

  container_definitions = jsonencode([
    {
      name      = "jenkins"
      image     = "jenkins/jenkins:lts"
      essential = true

      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "JAVA_OPTS"
          value = "-Djenkins.install.runSetupWizard=false"
        }
      ]
    }
  ])
}
