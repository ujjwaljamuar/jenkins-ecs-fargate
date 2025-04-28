# terraform/outputs/outputs.tf

output "api_gateway_url" {
  description = "The URL of the API Gateway for starting and stopping Jenkins"
  value       = aws_api_gateway_rest_api.api.invoke_url
}

output "start_jenkins_lambda_arn" {
  description = "The ARN of the Lambda function to start Jenkins"
  value       = aws_lambda_function.start_jenkins.arn
}

output "stop_jenkins_lambda_arn" {
  description = "The ARN of the Lambda function to stop Jenkins"
  value       = aws_lambda_function.stop_jenkins.arn
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.jenkins_cluster.name
}

output "ecs_task_definition" {
  description = "The ECS task definition for Jenkins"
  value       = aws_ecs_task_definition.jenkins_task.family
}
