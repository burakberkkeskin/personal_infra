module "vpc" {
  source = "../modules/vpc"
  region = var.aws_region
  zone = var.aws_zone
  name = "Main"
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "elastic-ip" {
  source = "../modules/elastic-ip"
  name = "Main"
}

module "ec2_instance" {
  source = "../modules/ec2-instance"
  region = var.aws_region
  zone = var.aws_zone
  ami = var.ec2_instance_ami
  instance_type = var.ec2_instance_type
  name = var.project_name
  key_name = var.key_name
  public_key_path = var.ec2_public_key_path
  subnet_id = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.vpc.egress_security_group_id ,module.vpc.ssh_security_group_id, module.vpc.http_security_group_id]
  eip_id = module.elastic-ip.elastic_ip_id
  user_data = var.ec2_user_data
  role_policy = var.ec2_role_policy
  depends_on = [
    module.vpc
  ]
}

# module "load_balancer" {
#   source = "../modules/application-load-balancer"
#   name = var.project_name
#   enable_deletion_protection = var.lb_enable_deletion_protection
#   vpc_id = module.vpc.vpc_id
#   security_groups = [module.vpc.http_security_group_id]
#   subnets = module.vpc.public_subnet_ids
#   tags = var.alb_tags
#   health_check_options = var.health_check_options
#   instance_ids = [module.ec2_instance.instance_id]
# }