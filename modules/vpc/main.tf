resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  tags = merge(
    var.tags, 
    {
      Name = var.vpc_name
    }
  )
}

resource "aws_subnet" "public" {
  count             = 3
  vpc_id            = aws_vpc.this.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 3, count.index)

  tags = merge(
    var.tags,
    {
      Name = "public-${split("-", data.aws_availability_zones.available.names[count.index])[2]}"
    }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags, 
    {
      Name = var.vpc_name
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags, 
    {
      Name = var.vpc_name
    }
  )
}

resource "aws_main_route_table_association" "this" {
  vpc_id         = aws_vpc.this.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

  timeouts {
    create = "5m"
  }
}

resource "aws_security_group" "ecs" {
  name        = "ecs-ec2-sg"
  description = "Allow SSH and HHTP"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags, 
    {
      Name = var.vpc_name
    }
  )
}

resource "aws_security_group" "rds" {
  name        = "rds-sg"
  description = "Allow connect to RDS"
  vpc_id      = aws_vpc.this.id

  ingress {
    description     = "RDS"
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }

  tags = merge(
    var.tags, 
    {
      Name = var.vpc_name
    }
  )
}