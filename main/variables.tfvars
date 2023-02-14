// general variables
project_name = "main"
aws_region = "eu-central-1"
aws_zone = "eu-central-1a"

// vpc variables
vpc_cidr_block = "10.10.0.0/16"

public_subnets = [ {
  availability_zone = "eu-central-1a"
  cidr_block = "10.10.20.0/24"
  },
  {
  availability_zone = "eu-central-1b"
  cidr_block = "10.10.40.0/24"
  } 
]
private_subnets = [ {
  availability_zone = "eu-central-1a"
  cidr_block = "10.10.21.0/24"
  },
  {
  availability_zone = "eu-central-1b"
  cidr_block = "10.10.41.0/24"
  } 
]

// ec2 variables
key_name = "fatheraws"
ec2_count = 1
ec2_public_key_path = "~/.ssh/awsf.pub"
ec2_instance_ami = "ami-03e08697c325f02ab"
ec2_instance_type = "m5.xlarge"
ec2_user_data = <<EOF
#!/bin/bash
sudo apt-get update
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
sudo docker container run -d -p 80:80 --name safwebsite safderun/website
EOF
ec2_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF

// lb variables
lb_name = "main"
lb_enable_deletion_protection = false
lb_health_check_options = {
  path = "/"
  port = "80"
}
lb_listeners = [ {
      port = 80
      protocol = "HTTP"
      action = {
        type = "forward"
      }
    },
    {
      port = 443
      protocol = "HTTP"
      action = {
        type = "forward"
      }
    } ]

// cloudflare variables
cloudflare_record_type = "CNAME"
cloudflare_record_name = "lb"
cloudflare_record_proxied = true
cloudflare_ttl = 3600