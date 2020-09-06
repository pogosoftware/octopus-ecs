resource "random_password" "octopus_admin" {
  length = 24
  special = true
  override_special = "_%@"
}