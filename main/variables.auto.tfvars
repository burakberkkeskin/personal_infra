// general variables
project_name = "main"
aws_region = "eu-central-1"
aws_zone = "eu-central-1a"

// ec2 variables
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
cloudflare_record_name = "site"
cloudflare_record_proxied = true
cloudflare_ttl = 3600