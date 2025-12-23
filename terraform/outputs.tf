output "s3_bucket_name" {
  value = aws_s3_bucket.jenkins_home.bucket
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "execution_role_arn" {
  value = aws_iam_role.ecs_execution.arn
}

output "task_role_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "jenkins_task_definition_arn" {
  value = aws_ecs_task_definition.jenkins.arn
}
