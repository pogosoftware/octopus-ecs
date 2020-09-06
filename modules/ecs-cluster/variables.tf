variable aws_region {
  type        = string
  description = "The AWS region."
}

variable tags {
  type        = map(string)
  description = "The tags."
}

### ECS

variable ecs_cluster_name {
  type        = string
  description = "The ECS cluster name"
}

### LAUNCH CONFIGURATION
variable lc_instance_type {
  type    = string
}

variable lc_name_prefix {
  type    = string
}
variable lc_associate_public_ip_address {
  type    = bool
}

variable lc_enable_monitoring {
  type    = bool
}

variable lc_security_groups {
  type = list(string)
}

### AUTO SCALING GROUP

variable asg_name {
  type    = string
}

variable asg_max_size {
  type    = number
}

variable asg_min_size {
  type    = number
}

variable asg_desired_capacity {
  type    = number
}

### LB

variable lb_security_groups {
  type = list(string)
}

### VPC

variable vpc_id {
  type = string
}

variable vpc_subnet_ids {
  type = list(string)
}