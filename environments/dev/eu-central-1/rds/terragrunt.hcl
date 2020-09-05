terraform {
  source = "${get_terragrunt_dir()}/../../../../modules/rds"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  suffix      = local.environment_vars.locals.suffix
}

inputs = {
  db_identifier          = "octopus-${local.suffix}"
  db_engine              = "sqlserver-ex"
  db_engine_version      = "14.00.3294.2.v1"
  db_instance_class      = "db.t2.micro"
  db_storage_type        = "gp2"
  db_allocated_storage   = 30
  db_username            = "octopus"
  vpc_security_group_ids = [dependency.vpc.outputs.security_group_rds_id]
  vpc_subnet_ids         = dependency.vpc.outputs.public_subnet_ids
}