module "vpc" {
  source = "../modules/vpc"
  region = var.aws_region
  zone = var.aws_zone
  name = "Main"
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "ec2_instance" {
  source = "../modules/ec2-instance"
  region = var.aws_region
  zone = var.aws_zone
  ec2_count = var.ec2_count
  ami = var.ec2_instance_ami
  instance_type = var.ec2_instance_type
  name = var.project_name
  key_name = var.key_name
  public_key_path = var.ec2_public_key_path
  subnet_id = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.vpc.egress_security_group_id ,module.vpc.ssh_security_group_id, module.vpc.http_security_group_id]
  user_data = var.ec2_user_data
  role_policy = var.ec2_role_policy
  depends_on = [
    module.vpc
  ]
}

module "load_balancer" {
  source = "../modules/application-load-balancer"
  name = var.project_name
  enable_deletion_protection = var.lb_enable_deletion_protection
  vpc_id = module.vpc.vpc_id
  security_groups = [module.vpc.http_security_group_id, module.vpc.egress_security_group_id]
  subnets = module.vpc.public_subnet_ids
  tags = var.lb_tags
  health_check_options = var.lb_health_check_options
  instance_ids = module.ec2_instance.instance_id
  listeners = var.lb_listeners
}

module "cloudflare_dns" {
  source = "../modules/cloudflare_dns"
  api_token = var.cloudflare_api_token
  zone_id = var.cloudflare_zone_id
  record_name = var.cloudflare_record_name
  record_value = module.load_balancer.lb_dns_name
  record_type = var.cloudflare_record_type
  record_proxied = var.cloudflare_record_proxied
}
