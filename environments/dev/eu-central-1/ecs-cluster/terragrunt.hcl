terraform {
  source = "${get_terragrunt_dir()}/../../../../modules/ecs-cluster"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  ecs_cluster_name = "octopus"
  lc_instance_type = "t2.micro"
  lc_name_prefix = "ecs-"
  lc_associate_public_ip_address = true
  lc_enable_monitoring = false
  lc_security_groups = [dependency.vpc.outputs.security_group_ecs_id]
  asg_name = "ecs"
  asg_min_size = 1
  asg_max_size = 1
  asg_desired_capacity = 1
  asg_subnet_ids = dependency.vpc.outputs.public_subnet_ids
}