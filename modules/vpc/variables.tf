variable aws_region {
  type        = string
  description = "The AWS region."
}

variable vpc_name {
  type        = string
  description = "The VPC name."
}

variable vpc_cidr_block {
  type        = string
  description = "The CIDR block for the VPC."
}

variable tags {
  type        = map(string)
  description = "The tags."
}