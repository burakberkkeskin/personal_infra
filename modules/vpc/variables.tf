variable "region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "eu-central-1"
}
variable "zone" {
  description = "The AWS availability zone to deploy to"
  type        = string
  default     = "eu-central-1a"
}
variable "name" {
  description = "Name tag of the general vpc resources"
  type        = string
  default     = "main"
}
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnets" {
  description = "Subnets options for each subnet"
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
  // default to 1 public subnet with given zone
  default = [{
    availability_zone = "eu-central-1a"
    cidr_block        = "10.10.10.0/24"
  }]
}

variable "private_subnets" {
  description = "Subnets options for each subnet"
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = [{
    availability_zone = "eu-central-1a"
    cidr_block        = "10.10.11.0/24"
  }]

}

variable "ingress_security_groups" {
  description = "Ingress security groups"
  type = map(object({
    name        = string
    description = string
    ingress = list(object({
      description      = string
      from_port        = string
      to_port          = string
      protocol         = string
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
    }))
  }))
  default = {
    ssh = {
      name        = "ssh"
      description = "Allow SSH traffic"
      ingress = [
        {
          description      = "Allow SSH traffic"
          from_port        = "22"
          to_port          = "22"
          protocol         = "tcp"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        },
      ]
    },
    http = {
      name        = "http"
      description = "Allow HTTP traffic"
      ingress = [
        {
          description      = "Allow HTTP traffic"
          from_port        = "80"
          to_port          = "80"
          protocol         = "tcp"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        },
      ]
    },
    https = {
      name        = "https"
      description = "Allow HTTPS traffic"
      ingress = [
        {
          description      = "Allow HTTPS traffic"
          from_port        = "443"
          to_port          = "443"
          protocol         = "tcp"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        },
      ]
    },
  }
}

variable "egress_security_groups" {
  description = "Egress security groups"
  type = map(object({
    name        = string
    description = string
    egress = list(object({
      description      = string
      from_port        = string
      to_port          = string
      protocol         = string
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
    }))
  }))
  default = {
    all = {
      name        = "all"
      description = "Allow All Egress traffic"
      egress = [
        {
          description      = "Allow All Egress traffic"
          from_port        = "0"
          to_port          = "0"
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        },
      ]
    }
  }
}
