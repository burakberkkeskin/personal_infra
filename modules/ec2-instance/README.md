<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

No requirements.
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
	 ec2_count  = 
	 public_key_path  = 
	 security_group_ids  = 
	 subnet_id  = 

	 # Optional variables
	 ami  = "ami-0a5b5c0ea66ec560d"
	 assume_role_policy  = "{\n\"Version\": \"2012-10-17\",\n\"Statement\": [\n  {\n    \"Action\": \"sts:AssumeRole\",\n    \"Principal\": {\n      \"Service\": \"ec2.amazonaws.com\"\n    },\n    \"Effect\": \"Allow\",\n    \"Sid\": \"\"\n  }\n]\n}\n"
	 ec2_instance_type  = "t2.micro"
	 ec2_intance_ami  = "ami-0a5b5c0ea66ec560d"
	 eip_id  = []
	 instance_type  = "t2.micro"
	 key_name  = "Main"
	 name  = "Main"
	 region  = "eu-central"
	 role_policy  = ""
	 user_data  = ""
	 zone  = "eu-central-1a"
}
```
## Resources

| Name | Type |
|------|------|
| [aws_eip_association.eip_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_iam_instance_profile.role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | The AMI to use for the instance | `string` | `"ami-0a5b5c0ea66ec560d"` | no |
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | Assume Role Policy | `string` | `"{\n\"Version\": \"2012-10-17\",\n\"Statement\": [\n  {\n    \"Action\": \"sts:AssumeRole\",\n    \"Principal\": {\n      \"Service\": \"ec2.amazonaws.com\"\n    },\n    \"Effect\": \"Allow\",\n    \"Sid\": \"\"\n  }\n]\n}\n"` | no |
| <a name="input_ec2_count"></a> [ec2\_count](#input\_ec2\_count) | The number of instances to create | `number` | n/a | yes |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | Instance Type | `string` | `"t2.micro"` | no |
| <a name="input_ec2_intance_ami"></a> [ec2\_intance\_ami](#input\_ec2\_intance\_ami) | The AMI to use for the instance | `string` | `"ami-0a5b5c0ea66ec560d"` | no |
| <a name="input_eip_id"></a> [eip\_id](#input\_eip\_id) | Elastic IP ID | `list(string)` | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance Type | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the key pair to use | `string` | `"Main"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name tag of the resources | `string` | `"Main"` | no |
| <a name="input_public_key_path"></a> [public\_key\_path](#input\_public\_key\_path) | Path to the private key | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy to | `string` | `"eu-central"` | no |
| <a name="input_role_policy"></a> [role\_policy](#input\_role\_policy) | Policy for the ec2 role | `string` | `""` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | VPC Security Group IDs | `list(string)` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID | `string` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data to pass to instance | `string` | `""` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The availability zone to deploy to | `string` | `"eu-central-1a"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | n/a |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->