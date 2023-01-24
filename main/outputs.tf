output "ec2_instance_public_ip" {
  value = module.ec2_instance.public_ip
}
output "ec2_instance_private_ip" {
  value = module.ec2_instance.private_ip
}
# output "elb_dns_name" {
#   value = module.load_balancer.elb_dns_name
# }