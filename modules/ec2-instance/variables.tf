variable "region" {
  description = "The region to deploy to"
  type = string
  default = "eu-central"
}
variable "zone" {
  description = "The availability zone to deploy to"
  type = string
  default = "eu-central-1a"
}
variable "name" {
  description = "Name tag of the resources"
  type        = string 
  default     = "Main"
}

variable "key_name" {
  description = "Name of the key pair to use"
  type        = string 
  default     = "Main"  
}
variable "public_key_path" {
  description = "Path to the private key"
  type        = string 
  sensitive = true
}

variable "ami" {
  description = "The AMI to use for the instance"
  type = string
  default = "ami-0a5b5c0ea66ec560d"
}
variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}
variable "security_group_ids" {
  description = "VPC Security Group IDs"
  type        = list(string)
}
variable "eip_id" {
  description = "Elastic IP ID"
  type        = string
}
variable "ec2_intance_ami" {
  description = "The AMI to use for the instance"
  type = string
  default = "ami-0a5b5c0ea66ec560d"
}
variable "ec2_instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}
variable "user_data" {
  description = "User data to pass to instance"
  type        = string
  default     = ""
  sensitive = true
}

variable "assume_role_policy" {
  description = "Assume Role Policy"
  type = string
  default =  <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "ec2.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
  }
]
}
EOF
}

variable "role_policy" {
  description = "Policy for the ec2 role"
  type = string
  default = ""
}