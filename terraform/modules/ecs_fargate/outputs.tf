output "ecs_cluster_name" {
  description = "Name of the ECS cluster running Jenkins"
  value       = aws_ecs_cluster.jenkins.name
}
