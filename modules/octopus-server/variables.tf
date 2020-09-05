variable aws_region {
  type        = string
  description = "The AWS region."
}

### ECS

variable ecs_cluster_id {
  type = string
}

### OCTOPUS SERVICE
variable octopus_image {
  type    = string
}

variable octopus_name {
  type    = string
}
variable octopus_admin_username {
  type    = string
}

variable octopus_admin_password {
  type = string
}

variable octopus_admin_email {
  type    = string
}

variable octopus_admin_api_key {
  type    = string
  default = ""
}

variable octopus_license {
  type    = string
  default = ""
}

variable octopus_master_key {
  type    = string
  default = ""
}

variable octopus_host_port {
  type    = number
}

variable octopus_cpu {
  type    = number
}

variable octopus_memory {
  type    = number
}

variable octopus_desired_count {
  type    = number
}

### DB

variable db_address {
  type = string
}

variable db_port {
  type = number
}

variable db_database {
  type = string
}

variable db_username {
  type = string
}

variable db_password {
  type = string
}