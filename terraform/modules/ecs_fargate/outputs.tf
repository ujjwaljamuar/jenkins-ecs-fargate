output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.jenkins_cluster.name
}

output "ecs_task_definition" {
  description = "The ECS task definition for Jenkins"
  value       = aws_ecs_task_definition.jenkins_task.family
}
