variable aws_region {
  type        = string
  default     = "eu-central-1"
  description = "The AWS region."
}

### VPC

variable vpc_cidr_block {
  type        = string
  default     = "10.240.0.0/24"
  description = "The CIDR block for the VPC."
}

### OCTOPUS SERVICE

variable octopus_image {
  type    = string
  default = "octopusdeploy/octopusdeploy:2020.3.4-linux"
}

variable octopus_name {
  type    = string
  default = "octopus-server"
}
variable octopus_admin_username {
  type    = string
  default = "octoadmin"
}

variable octopus_admin_password {
  type = string
}

variable octopus_admin_email {
  type    = string
  default = "octo@admin.com"
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
  default = 80
}

variable octopus_cpu {
  type    = number
  default = 512
}

variable octopus_memory {
  type    = number
  default = 512
}

variable octopus_desired_count {
  type    = number
  default = 1
}
### ECS

variable ecs_cluster_name {
  type        = string
  default     = "octopus"
  description = "The ECS cluster name"
}

### LAUNCH CONFIGURATION
variable lc_instance_type {
  type    = string
  default = "t2.micro"
}

variable lc_name_prefix {
  type    = string
  default = "ecs-"
}
variable lc_associate_public_ip_address {
  type    = bool
  default = true
}

variable lc_enable_monitoring {
  type    = bool
  default = false
}

### AUTO SCALING GROUP

variable asg_name {
  type    = string
  default = "ecs"
}

variable asg_max_size {
  type    = number
  default = 1
}

variable asg_min_size {
  type    = number
  default = 1
}

variable asg_desired_capacity {
  type    = number
  default = 1
}
### DB
variable db_identifier {
  type    = string
  default = "octopus-dh78s"
}

variable db_username {
  type    = string
  default = "octopus"
}

variable db_password {
  type = string
}

variable db_port {
  type    = number
  default = 1433
}

variable publicly_accessible {
  type    = bool
  default = false
}

variable db_engine {
  type    = string
  default = "sqlserver-ex"
}

variable db_engine_version {
  type    = string
  default = "14.00.3294.2.v1"
}

variable db_instance_class {
  type    = string
  default = "db.t2.micro"
}

variable db_storage_type {
  type    = string
  default = "gp2"
}

variable db_allocated_storage {
  type    = string
  default = 20
}