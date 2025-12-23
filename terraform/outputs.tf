output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.jenkins_home.bucket
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

output "security_group_id" {
  value = aws_security_group.jenkins_sg.id
}
