// General Variables
variable "project_name" {
  description = "The name tag of the general resources"
  type        = string
  default     = "Main"
}
variable "aws_region" {
  description = "The Default AWS region to use"
  type        = string
  default     = "eu-central-1"
}
variable "aws_zone" {
  description = "The Default AWS availability zone to use"
  type        = string
  default     = "eu-central-1a"
}

// VPC Variables
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default = "10.10.0.0/16"
}

variable "public_subnets" {
  description = "Public subnets options for each subnet"
  type = list(object({
    cidr_block = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "Private subnets options for each subnet"
  type = list(object({
    cidr_block = string
    availability_zone = string
  }))
}

// EC2 Instance Variables
variable "key_name" {
  description = "The name of the key pair to use"
  type        = string
  default     = "Main"
}
variable "ec2_count" {
  description = "The number of instances to create"
  type        = number
  default     = 1
}
variable "ec2_public_key_path" {
  description = "The path to the publica key"
  type        = string
}
variable "ec2_instance_ami" {
  description = "The AMI to use for the instance"
  type = string
  default = "ami-0a5b5c0ea66ec560d"
}
variable "ec2_instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}
variable "ec2_user_data" {
  description = "User data to pass to instance"
  type        = string
}
variable "ec2_role_policy" {
  description = "Assume Role Policy"
  type = string
  default = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

variable "lb_enable_deletion_protection" {
  description = "Enable deletion protection on the load balancer"
  type        = bool
  default     = false
}

variable "lb_tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {
    "Name" = "Main"
  }
}

variable "lb_health_check_options" {
  description = "The health check options."
  type = object({
    path = string
    port = string
  })
  default = {
    path = "/"
    port = "80"
  }
}