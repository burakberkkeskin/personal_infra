variable "name" {
  description = "General name of the resources"
  type        = string
  default     = "Main"
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer."
  type        = bool
  default     = true
}
variable "security_groups" {
  description = "The security groups to assign to the load balancer."
  type        = list(string)
}
variable "subnets" {
  description = "The subnets to assign to the load balancer."
  type        = list(string)
}
variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
variable "access_logs" {
  description = "The name of the S3 bucket to store logs in."
  type        = object({
    enabled = bool
    name = string
    prefix = string
  })
  default = {
    enabled = false
    name = ""
    prefix = ""
  }
}
variable "health_check_options" {
  description = "The health check options."
  type = object({
    path = string
    port = string
  })
}
variable "instance_ids" {
  description = "The instance ids to attach to the target group."
  type        = list(string)
}
variable "listeners" {
  description = "The listeners to create on the load balancer."
  type = list(object({
    port     = number
    protocol = string
    action   = object({
      type             = string
    })
  }))
}