resource "aws_key_pair" "main" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "main" {
  count             = var.ec2_count
  availability_zone = var.zone

  // Resource Settings
  ami           = var.ami
  instance_type = var.instance_type

  // Network Settings
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids

  // Iam Settings
  iam_instance_profile = aws_iam_instance_profile.role_instance_profile.name

  // Block Device Settings
  root_block_device {
    volume_size           = var.ec2_disk_size
    volume_type           = "gp2"
    delete_on_termination = true
  }

  # ebs_block_device {
  #   device_name = "/dev/sda1"
  #   volume_size = 8
  #   volume_type = "gp2"
  #   delete_on_termination = true
  # }

  // User Data Settings
  user_data = var.user_data

  // Key Pair Settings
  key_name = aws_key_pair.main.key_name

  // Tags
  tags = {
    "Name" = var.name
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.name}-role"

  assume_role_policy = <<EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
  }
  EOF

  tags = {
    Name = "${var.name}-role"
  }
}

resource "aws_eip_association" "eip_assoc" {
  // if eip is not provided, then it will not create eip association
  count         = length(var.eip_id) > 0 ? length(var.eip_id) : 0
  instance_id   = aws_instance.main[count.index].id
  allocation_id = var.eip_id[count.index]
}

resource "aws_iam_role_policy" "role_policy" {
  name = "${var.name}-role-policy"
  role = aws_iam_role.ec2_role.id

  policy = var.role_policy
}

resource "aws_iam_instance_profile" "role_instance_profile" {
  name = "${var.name}-role-instance-profile"
  role = aws_iam_role.ec2_role.name
}
