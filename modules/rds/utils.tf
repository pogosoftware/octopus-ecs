resource "random_password" "octopus" {
  length = 24
  special = true
  override_special = "_%@"
}