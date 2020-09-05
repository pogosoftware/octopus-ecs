terraform {
  source = "${get_terragrunt_dir()}/../../../../modules/vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vpc_name       = "Octopus"
  vpc_cidr_block = "10.240.0.0/24"
}