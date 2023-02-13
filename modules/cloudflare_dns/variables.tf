// Cloudflare Variables
variable "domain" {
  description = "The Cloudflare zone name"
  type        = string
}
variable "record_type" {
  description = "The Cloudflare record type"
  type        = string
}
variable "record_name" {
  description = "The Cloudflare record name"
  type        = string
}
variable "record_value" {
  description = "The Cloudflare record value"
  type        = string
}
variable "record_proxied" {
  description = "The Cloudflare record proxied"
  type        = bool
  default     = true
}