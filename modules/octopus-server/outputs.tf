output octopus_admin_username {
  value = var.octopus_admin_username
}

output octopus_admin_password {
  value = random_password.octopus_admin.result
  sensitive = true
}