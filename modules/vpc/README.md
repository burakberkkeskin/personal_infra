<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

No requirements.
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
	 source  = "<module-path>"

	 # Optional variables
	 name  = "main"
	 private_subnets  = [
  {
    "availability_zone": "eu-central-1a",
    "cidr_block": "10.10.11.0/24"
  }
]
	 public_subnets  = [
  {
    "availability_zone": "eu-central-1a",
    "cidr_block": "10.10.10.0/24"
  }
]
	 region  = "eu-central-1"
	 vpc_cidr_block  = "10.10.0.0/16"
	 zone  = "eu-central-1a"
}
```
## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route_table.private_main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_v4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_v4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name tag of the general vpc resources | `string` | `"main"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Subnets options for each subnet | <pre>list(object({<br>    cidr_block = string<br>    availability_zone = string<br>  }))</pre> | <pre>[<br>  {<br>    "availability_zone": "eu-central-1a",<br>    "cidr_block": "10.10.11.0/24"<br>  }<br>]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Subnets options for each subnet | <pre>list(object({<br>    cidr_block = string<br>    availability_zone = string<br>  }))</pre> | <pre>[<br>  {<br>    "availability_zone": "eu-central-1a",<br>    "cidr_block": "10.10.10.0/24"<br>  }<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to deploy to | `string` | `"eu-central-1"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block for the VPC. | `string` | `"10.10.0.0/16"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The AWS availability zone to deploy to | `string` | `"eu-central-1a"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_egress_security_group_id"></a> [egress\_security\_group\_id](#output\_egress\_security\_group\_id) | Security Group IDs |
| <a name="output_http_security_group_id"></a> [http\_security\_group\_id](#output\_http\_security\_group\_id) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_ssh_security_group_id"></a> [ssh\_security\_group\_id](#output\_ssh\_security\_group\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->