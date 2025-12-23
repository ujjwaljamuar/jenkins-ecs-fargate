locals {
  ecs_cluster_name = "${var.project_name}-cluster"
  log_group_name   = "/ecs/${var.project_name}"
  s3_bucket_name   = "${var.project_name}-home-${data.aws_caller_identity.current.account_id}"
}
