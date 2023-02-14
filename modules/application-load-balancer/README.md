<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

No requirements.
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
	 health_check_options  = 
	 instance_ids  = 
	 listeners  = 
	 security_groups  = 
	 subnets  = 
	 vpc_id  = 

	 # Optional variables
	 access_logs  = {
  "enabled": false,
  "name": "",
  "prefix": ""
}
	 enable_deletion_protection  = true
	 name  = "Main"
	 tags  = {}
}
```
## Resources

| Name | Type |
|------|------|
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | The name of the S3 bucket to store logs in. | <pre>object({<br>    enabled = bool<br>    name = string<br>    prefix = string<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "name": "",<br>  "prefix": ""<br>}</pre> | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. | `bool` | `true` | no |
| <a name="input_health_check_options"></a> [health\_check\_options](#input\_health\_check\_options) | The health check options. | <pre>object({<br>    path = string<br>    port = string<br>  })</pre> | n/a | yes |
| <a name="input_instance_ids"></a> [instance\_ids](#input\_instance\_ids) | The instance ids to attach to the target group. | `list(string)` | n/a | yes |
| <a name="input_listeners"></a> [listeners](#input\_listeners) | The listeners to create on the load balancer. | <pre>list(object({<br>    port     = number<br>    protocol = string<br>    action   = object({<br>      type             = string<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | General name of the resources | `string` | `"Main"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The security groups to assign to the load balancer. | `list(string)` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The subnets to assign to the load balancer. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | n/a |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->