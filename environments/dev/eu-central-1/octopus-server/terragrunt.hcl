terraform {
  source = "${get_terragrunt_dir()}/../../../../modules/octopus-server"
}

include {
  path = find_in_parent_folders()
}

dependency "rds" {
  config_path = "../rds"
}

dependency "ecs_cluster" {
  config_path = "../ecs-cluster"
}

inputs = {
  octopus_image = "octopusdeploy/octopusdeploy:2020.3.4-linux"
  octopus_name = "octopus-server"
  octopus_admin_username = "octoadmin"
  octopus_admin_email = "octo@admin.com"
  octopus_host_port = 80
  octopus_cpu = 512
  octopus_memory = 512
  octopus_desired_count = 1

  db_address = dependency.rds.outputs.rds_octopus_address
  db_port = dependency.rds.outputs.rds_octopus_port
  db_database = dependency.rds.outputs.rds_octopus_database
  db_username = dependency.rds.outputs.rds_octopus_username
  db_password = dependency.rds.outputs.rds_octopus_password

  ecs_cluster_id = dependency.ecs_cluster.outputs.ecs_cluster_octopus_id
}