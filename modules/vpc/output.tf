output "vpc_id" {
  value = aws_vpc.main.id
}

// Subnet IDs

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}
output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

// Security Group IDs
output "egress_security_group_ids" {
  value = { for key, sg in var.egress_security_groups : key => aws_security_group.egress[key].id }
}
output "ingress_security_group_ids" {
  value = { for key, sg in var.ingress_security_groups : key => aws_security_group.ingress[key].id }
}
