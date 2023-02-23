resource "cloudflare_record" "cloudflare_dns" {
  zone_id = var.zone_id
  name    = var.record_name
  value   = var.record_value
  type    = var.record_type
  proxied = var.record_proxied
}