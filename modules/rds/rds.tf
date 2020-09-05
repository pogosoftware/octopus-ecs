resource "aws_db_instance" "octopus" {
  identifier = var.db_identifier

  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class
  port           = var.db_port

  storage_type      = var.db_storage_type
  allocated_storage = var.db_allocated_storage

  username = var.db_username
  password = var.db_password

  publicly_accessible = var.publicly_accessible

  parameter_group_name = "default.sqlserver-ex-14.0"
  skip_final_snapshot  = true

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = merge(
    var.tags, 
    {
      Name = var.db_identifier
    }
  )
}

resource "aws_db_subnet_group" "this" {
  name       = var.db_identifier
  subnet_ids = var.vpc_subnet_ids

  tags = merge(
    var.tags, 
    {
      Name = var.db_identifier
    }
  )
}