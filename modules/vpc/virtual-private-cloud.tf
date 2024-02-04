resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnets, count.index).cidr_block
  availability_zone = element(var.public_subnets, count.index).availability_zone
  tags = {
    "Name" = "${var.name}_public_${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnets, count.index).cidr_block
  availability_zone = element(var.private_subnets, count.index).availability_zone
  tags = {
    "Name" = "${var.name}_private_${count.index}"
  }
}

//// Create a route table for the public subnets

// Create route table for public
resource "aws_route_table" "public_v4" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.main.id
  }
  tags = {
    "Name" = "${var.name}_public_v4"
  }
}

resource "aws_route_table_association" "public_v4" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_v4.id
}

// Create a route table for the private subnets
resource "aws_route_table" "private_main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_main.id
}

## Create egress security groups

resource "aws_security_group" "egress" {
  for_each    = var.egress_security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.main.id
  dynamic "egress" {
    for_each = each.value.egress
    content {
      description      = egress.value.description
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
    }

  }
  tags = {
    "Name" = each.value.name
  }
}

## Create ingress security groups

resource "aws_security_group" "ingress" {
  for_each    = var.ingress_security_groups
  name        = "${var.name}-${each.value.name}"
  description = each.value.description
  vpc_id      = aws_vpc.main.id
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      description      = ingress.value.description
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
    }

  }
  tags = {
    "Name" = each.value.name
  }
}
