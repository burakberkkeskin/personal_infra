variable "region" {
  description = "AWS region to deploy to"
  type = string
  default = "eu-central-1"
}
variable "zone" {
  description = "The AWS availability zone to deploy to"
  type = string
  default = "eu-central-1a"
}
variable "name" {
  description = "Name tag of the general vpc resources"
  type        = string
  default     = "Main"
}
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default = "10.10.0.0/16"
}
variable "subnet_count" {
  description = "Subnet Count"
  type = map(number)
  default = {
    "public" = 1,
    "private" = 1
  }
}

variable "public_subnets" {
  description = "Subnets options for each subnet"
  type = list(map(string))
  default = [{
    "cidr_block" = "10.10.10.0/24",
    "availability_zone" = "eu-central-1a"
  }]
}

variable "private_subnets" {
  description = "Subnets options for each subnet"
  type = list(map(string))
  default = [{
    "cidr_block" = "10.10.11.0/24",
    "availability_zone" = "eu-central-1a"
  }]
}

variable "public_subnet_cidr_blocks" {
  description = "The CIDR block for the public subnet."
  type = list(string)
  default = [
    "10.10.10.0/24",
    "10.10.20.0/24",
    "10.10.30.0/24" 
    ]
}
variable "private_subnet_cidr_blocks" {
  description = "The CIDR block for the private subnet."
  type = list(string)
  default = [
    "10.10.11.0/24",
    "10.10.21.0./24",
    "10.10.31.0/24"
    ]
}