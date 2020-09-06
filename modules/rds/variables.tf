variable aws_region {
  type        = string
  description = "The AWS region."
}

variable tags {
  type        = map(string)
  description = "The tags."
}

variable db_identifier {
  type    = string
}

variable db_engine {
  type    = string
}

variable db_engine_version {
  type    = string
}

variable db_instance_class {
  type    = string
}

variable db_username {
  type    = string
}

variable db_port {
  type    = number
  default = 1433
}

variable publicly_accessible {
  type    = bool
  default = false
}

variable db_storage_type {
  type    = string
}

variable db_allocated_storage {
  type    = string
}

variable vpc_security_group_ids {
  type = list(string)
}

variable vpc_subnet_ids {
  type = list(string)
}