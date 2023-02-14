<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.0.0-rc2 |
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
	 api_token  = 
	 record_name  = 
	 record_type  = 
	 record_value  = 
	 zone_id  = 

	 # Optional variables
	 record_proxied  = true
}
```
## Resources

| Name | Type |
|------|------|
| [cloudflare_record.cloudflare_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/4.0.0-rc2/docs/resources/record) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | The Cloudflare API token | `string` | n/a | yes |
| <a name="input_record_name"></a> [record\_name](#input\_record\_name) | The Cloudflare record name | `string` | n/a | yes |
| <a name="input_record_proxied"></a> [record\_proxied](#input\_record\_proxied) | The Cloudflare record proxied | `bool` | `true` | no |
| <a name="input_record_type"></a> [record\_type](#input\_record\_type) | The Cloudflare record type | `string` | n/a | yes |
| <a name="input_record_value"></a> [record\_value](#input\_record\_value) | The Cloudflare record value | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The Cloudflare zone ID | `string` | n/a | yes |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->