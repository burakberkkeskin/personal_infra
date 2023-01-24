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
  count = length(var.public_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnets, count.index).cidr_block
  availability_zone = element(var.public_subnets, count.index).availability_zone
  tags = {
    "Name" = "${var.name}_public_${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnets, count.index).cidr_block
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
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    "Name" = "${var.name}_public_v4"
  }
}

resource "aws_route_table_association" "public_v4" {
  count = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_v4.id
}

// Create a route table for the private subnets
resource "aws_route_table" "private_main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "private" {
  count = var.subnet_count.private
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_main.id
}

//// Create security groups for the VPC

// Allow all traffic to egress security group
resource "aws_security_group" "egress" {
  name        = "${var.name}-egress"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.main.id

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = [ "::/0" ]
  }

  tags = {
    "Name" = "${var.name}-egress"
  }
}

// Allow ssh traffic to ingress security group
resource "aws_security_group" "ssh" {
  name        = "${var.name}-ssh"
  description = "Allow minimal traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow SSH traffic"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = "${var.name}-ssh"
  }
}

// Allow http traffic to ingress security group
resource "aws_security_group" "http" {
  name        = "${var.name}-http"
  description = "Allow http traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = "${var.name}-http"
  }
}