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

variable "lb_enable_deletion_protection" {
  description = "Enable deletion protection on the load balancer"
  type        = bool
  default     = false
}

variable "lb_tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default = {
    "Name" = "Main"
  }
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
variable "lb_listeners" {
  description = "The list of listeners."
  type = list(object({
    port     = number
    protocol = string
    action = object({
      type = string
    })
  }))
  default = [
    {
      port     = 80
      protocol = "HTTP"
      action = {
        type = "forward"
      }
    },
    {
      port     = 443
      protocol = "HTTP"
      action = {
        type = "forward"
      }
    }
  ]
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
