resource "aws_security_group" "ecs" {
  name        = "ecs-ec2-sg"
  description = "Allow SSH and HHTP"
  vpc_id      = aws_vpc.this.id

  tags = merge(
    var.tags, 
    {
      Name = "ecs-ec2-sg"
    }
  )
}

resource "aws_security_group" "rds" {
  name        = "rds-sg"
  description = "Allow connect to RDS"
  vpc_id      = aws_vpc.this.id

  tags = merge(
    var.tags, 
    {
      Name = "rds-sg"
    }
  )
}

resource "aws_security_group" "ecs_lb" {
  name        = "ecs-lb-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.this.id

  tags = merge(
    var.tags, 
    {
      Name = "ecs-lb-sg"
    }
  )
}

### ECS
resource "aws_security_group_rule" "ecs_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs.id
}

resource "aws_security_group_rule" "ecs_ingress_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_lb.id
  security_group_id        = aws_security_group.ecs.id
}

resource "aws_security_group_rule" "ecs_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs.id
}

### RDS
resource "aws_security_group_rule" "rds_ingress_mssql" {
  type                     = "ingress"
  from_port                = 1433
  to_port                  = 1433
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs.id
  security_group_id        = aws_security_group.rds.id
}

### ECS LB
resource "aws_security_group_rule" "ecs_lb_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_lb.id
}

resource "aws_security_group_rule" "ecs_egress_ecs_ecs_sg" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs.id
  security_group_id        = aws_security_group.ecs_lb.id
}