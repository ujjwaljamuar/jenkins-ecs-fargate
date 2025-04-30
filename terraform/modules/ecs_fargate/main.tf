resource "aws_ecs_cluster" "jenkins" {
  name = "jenkins-cluster"
}

resource "aws_ecs_task_definition" "jenkins" {
  family                   = "jenkins-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "jenkins"
      image     = "<your-custom-jenkins-image-with-s3-restore>"
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
      essential = true
      environment = [
        { name = "S3_BUCKET", value = aws_s3_bucket.jenkins_data.bucket }
      ]
    }
  ])
}
