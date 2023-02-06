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
  default     = "main"
}
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default = "10.10.0.0/16"
}

variable "public_subnets" {
  description = "Subnets options for each subnet"
  type = list(object({
    cidr_block = string
    availability_zone = string
  }))
  // default to 1 public subnet with given zone
  default = [ {
    availability_zone = "eu-central-1a"
    cidr_block = "10.10.10.0/24"
  } ]
}

variable "private_subnets" {
  description = "Subnets options for each subnet"
  type = list(object({
    cidr_block = string
    availability_zone = string
  }))
  default = [ {
    availability_zone = "eu-central-1a"
    cidr_block = "10.10.11.0/24"
  } ]

}