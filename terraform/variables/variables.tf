# terraform/variables/variables.tf

variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "ap-south-1"
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS and Lambda"
  type        = list(string)
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  default     = "jenkins-cluster"
}

variable "task_definition" {
  description = "The ECS task definition for Jenkins"
  default     = "jenkins-task"
}

variable "lambda_role" {
  description = "The IAM role for Lambda functions"
  type        = string
}
