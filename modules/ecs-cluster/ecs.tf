resource "aws_ecs_cluster" "octopus" {
  name = var.ecs_cluster_name
}
