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
