variable "vpc_id" {}


variable "ecs_cluster_name" {
  
}

variable "lambda_role" {
  
}

locals {
  ecs_cluster_name = var.ecs_cluster_name
  lambda_role = var.lambda_role
  vpc_id = var.vpc_id
}