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
