terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}


provider "cloudflare" {
  api_token = var.cloudflare_api_token
}


resource "cloudflare_record" "cloudflare_dns" {
  zone_id = var.zone_id
  name    = var.record_name
  value   = var.record_value
  type    = var.record_type
  proxied = var.record_proxied
}