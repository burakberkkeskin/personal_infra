resource "cloudflare_record" "www" {
  domain  = "${var.domain}"
  name    = var.record_name
  value   = var.record_value
  type    = var.record_type
  proxied = var.record_proxied
}