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
output "egress_security_group_id" {
  value = aws_security_group.egress.id
}
output "ssh_security_group_id" {
  value = aws_security_group.ssh.id
}
output "http_security_group_id" {
  value = aws_security_group.http.id
}