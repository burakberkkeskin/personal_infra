module "vpc" {
  source = "../modules/vpc"
  region = var.aws_region
  zone   = var.aws_zone
  name   = var.project_name
  public_subnets = [{
    availability_zone = "eu-central-1a"
    vpc_cidr_block    = "10.10.0.0/16"
    cidr_block        = "10.10.20.0/24"
    },
    {
      availability_zone = "eu-central-1b"
      cidr_block        = "10.10.40.0/24"
    }
  ]
  private_subnets = [{
    availability_zone = "eu-central-1a"
    cidr_block        = "10.10.21.0/24"
    },
    {
      availability_zone = "eu-central-1b"
      cidr_block        = "10.10.41.0/24"
    }
  ]
  ingress_security_groups = {
    ssh = {
      name        = "ssh"
      description = "allow ssh ingress traffic"
      ingress = [
        {
          description      = "Allow SSH traffic"
          from_port        = "22"
          to_port          = "22"
          protocol         = "tcp"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        }
      ]
    }
    http = {
      name        = "http"
      description = "Allow HTTP(S) traffic"
      ingress = [
        {
          description      = "Allow HTTP traffic"
          from_port        = "80"
          to_port          = "80"
          protocol         = "tcp"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        },
        {
          description      = "Allow HTTPS traffic"
          from_port        = "443"
          to_port          = "443"
          protocol         = "tcp"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        },
      ]
    }
    wireguard = {
      name        = "wireguard"
      description = "Allow wireguard traffic"
      ingress = [
        {
          description      = "Allow wireguard traffic"
          from_port        = "51820"
          to_port          = "51820"
          protocol         = "udp"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        }
      ]
    }
  }
  egress_security_groups = {
    all = {
      name        = "all"
      description = "Allow All Egress traffic"
      egress = [
        {
          description      = "Allow All Egress traffic"
          from_port        = "0"
          to_port          = "0"
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        },
      ]
    }
  }
}

module "ec2_instance" {
  source             = "../modules/ec2-instance"
  region             = var.aws_region
  zone               = var.aws_zone
  ec2_count          = 1
  ami                = "ami-03e08697c325f02ab"
  instance_type      = "t2.micro"
  name               = var.project_name
  key_name           = "fatheraws"
  public_key         = var.ec2_public_key
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.vpc.ingress_security_group_ids["ssh"], module.vpc.ingress_security_group_ids["http"], module.vpc.egress_security_group_ids["all"]]
  user_data          = var.ec2_user_data
  role_policy        = var.ec2_role_policy
  depends_on = [
    module.vpc
  ]
}

module "load_balancer" {
  source                     = "../modules/application-load-balancer"
  name                       = var.project_name
  enable_deletion_protection = false
  vpc_id                     = module.vpc.vpc_id
  security_groups            = [module.vpc.ingress_security_group_ids["http"], module.vpc.egress_security_group_ids["all"]]
  subnets                    = module.vpc.public_subnet_ids
  tags = {
    "Name" = "Main"
  }
  health_check_options = {
    path = "/"
    port = "80"
  }
  instance_ids = module.ec2_instance.instance_id
  listeners = [{
    port     = 80
    protocol = "HTTP"
    action = {
      type = "forward"
    }
    },
    {
      port     = 443
      protocol = "HTTP"
      action = {
        type = "forward"
      }
  }]
}

module "cloudflare_dns" {
  source               = "../modules/cloudflare_dns"
  cloudflare_api_token = var.cloudflare_api_token
  zone_id              = var.cloudflare_zone_id
  record_name          = "site"
  record_value         = module.load_balancer.lb_dns_name
  record_type          = "CNAME"
  record_proxied       = true
}
