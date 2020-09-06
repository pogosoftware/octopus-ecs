resource "aws_ecs_task_definition" "service" {
  family = "octopus-server"
  container_definitions = templatefile("${path.module}/templates/octopus-server.tmpl", {
    name           = var.octopus_name,
    image          = var.octopus_image,
    cpu            = var.octopus_cpu,
    memory         = var.octopus_memory,
    host_port      = var.octopus_host_port,
    db_server      = var.db_address,
    db_port        = var.db_port,
    db_database    = var.db_database,
    db_username    = var.db_username,
    db_password    = var.db_password,
    admin_username = var.octopus_admin_username,
    admin_password = random_password.octopus_admin.result,
    admin_email    = var.octopus_admin_email,
    admin_api_key  = var.octopus_admin_api_key,
    license        = var.octopus_license,
    master_key     = var.octopus_master_key
  })

  requires_compatibilities = ["EC2"]
}

resource "aws_ecs_service" "octopus_server" {
  name            = var.octopus_name
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.octopus_desired_count

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
}