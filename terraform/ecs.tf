resource "aws_ecs_cluster" "this" {
  name = local.ecs_cluster_name
}
