output rds_octopus_address {
  value = aws_db_instance.octopus.address
}

output rds_octopus_port {
  value = aws_db_instance.octopus.port
}

output rds_octopus_database {
  value = aws_db_instance.octopus.id
}

output rds_octopus_username {
  value = aws_db_instance.octopus.username
}

output rds_octopus_password {
  value     = var.db_password
  sensitive = true
}