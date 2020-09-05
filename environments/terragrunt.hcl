locals {
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  aws_region  = local.region_vars.locals.aws_region
  environment = local.environment_vars.locals.environment
  suffix      = local.environment_vars.locals.suffix
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "state-${local.environment}-${local.aws_region}-${local.suffix}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.aws_region}"
  }
}

inputs = merge(
  local.region_vars.locals,
  local.environment_vars.locals
)