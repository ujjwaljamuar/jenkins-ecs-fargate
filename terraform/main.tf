# Backend configuration (optional, if using remote state like S3)
terraform {
  backend "s3" {
    bucket = "uj-terraform-state-files"
    key    = "jenkins-ecs-fargate/terraform.tfstate"
    region = "ap-south-1"
  }
}

module "ecs_fargate" {
  source = "./modules/ecs_fargate"
  ecs_cluster_name = var.ecs_cluster_name
  lambda_role = var.lambda_role
  vpc_id = data.aws_vpc.default
}

module "s3" {
  source = "./modules/s3"
  vpc_id = data.aws_vpc.default
}


module "lambda" {
  source      = "./modules/lambda"
  lambda_role = var.lambda_role
}

resource "aws_security_group" "jenkins_task" {
  name        = "jenkins-task-sg"
  description = "Jenkins task access"
  vpc_id      = data.aws_vpc.default

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