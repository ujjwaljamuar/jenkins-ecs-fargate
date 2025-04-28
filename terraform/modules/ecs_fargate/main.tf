# terraform/modules/ecs_fargate/main.tf

resource "aws_ecs_cluster" "jenkins_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "jenkins_task" {
  family                   = "jenkins-task"
  network_mode             = "awsvpc"
  execution_role_arn       = var.lambda_role
  task_role_arn            = var.lambda_role
  container_definitions    = file("terraform/modules/ecs_fargate/task_definition.json")
}

resource "aws_security_group" "jenkins_sg" {
  name_prefix = "jenkins-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
