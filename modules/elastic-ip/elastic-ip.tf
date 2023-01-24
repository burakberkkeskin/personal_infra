resource "aws_eip" "main" {
  vpc = true
  tags = {
    Name = var.name
  }
}