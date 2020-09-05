resource "aws_ecs_cluster" "this" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "service" {
  family = "octopus-server"
  container_definitions = templatefile("${path.module}/templates/octopus-server.tmpl", {
    name           = var.octopus_name,
    image          = var.octopus_image,
    cpu            = var.octopus_cpu,
    memory         = var.octopus_memory,
    host_port      = var.octopus_host_port,
    db_server      = aws_db_instance.octopus.address,
    db_port        = aws_db_instance.octopus.port,
    db_database    = aws_db_instance.octopus.id,
    db_username    = aws_db_instance.octopus.username,
    db_password    = var.db_password,
    admin_username = var.octopus_admin_username,
    admin_password = var.octopus_admin_password,
    admin_email    = var.octopus_admin_email,
    admin_api_key  = var.octopus_admin_api_key,
    license        = var.octopus_license,
    master_key     = var.octopus_master_key
  })

  requires_compatibilities = ["EC2"]
}

resource "aws_ecs_service" "octopus_server" {
  name            = var.octopus_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.octopus_desired_count

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
}