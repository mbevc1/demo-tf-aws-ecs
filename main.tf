module "network" {
  source = "./modules/network"

  az_count   = 2
  cidr_block = "172.17.0.0/16"

  providers = {
    aws = "aws" # .alias
  }
}

module "security" {
  source = "./modules/security"

  vpc_main_id = module.network.vpc_main_id
  name        = var.name
  app_port    = 80

  providers = {
    aws = "aws"
  }
}

module "logs" {
  source = "./modules/logs"

  name = var.name
}

module "alb" {
  source = "./modules/alb"

  vpc_main_id    = module.network.vpc_main_id
  public_subnets = module.network.public_subnets
  security_group = module.security.lb_sg
  name           = var.name

  providers = {
    aws = "aws"
  }
}

module "ecs" {
  source          = "./modules/ecs"
  private_subnets = module.network.private_subnets
  ecs_sg          = module.security.ecs_sg
  alb_tg          = module.alb.target_group
  name            = var.name
  app_image       = var.image
}
