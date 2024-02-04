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
variable "cloudflare_api_token" {
  description = "The Cloudflare API token"
  type        = string
}

// EC2 Instance Variables
variable "ec2_public_key" {
  description = "Public Key to use for the instance"
  type        = string
}
variable "ec2_user_data" {
  description = "User data to pass to instance"
  type        = string
}
variable "ec2_role_policy" {
  description = "Assume Role Policy"
  type        = string
  default     = <<EOF
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

// Lb Variables
variable "lb_name" {
  description = "General name of the resources"
  type        = string
  default     = "Main"
}

variable "lb_access_logs" {
  description = "The name of the S3 bucket to store logs in."
  type = object({
    enabled = bool
    name    = string
    prefix  = string
  })
  default = {
    enabled = false
    name    = ""
    prefix  = ""
  }
}

// Cloudflare Variables
variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID"
  type        = string
}
variable "cloudflare_record_type" {
  description = "The Cloudflare record type"
  type        = string
}
variable "cloudflare_record_name" {
  description = "The Cloudflare record name"
  type        = string
}
variable "cloudflare_record_proxied" {
  description = "The Cloudflare record proxied"
  type        = bool
  default     = true
}
variable "cloudflare_ttl" {
  description = "The Cloudflare record TTL"
  type        = number
  default     = 1
}
