module "network" {
  source = "./network"
  application_name = var.application_name
  subnets = var.subnets
  vpc_cidr = var.vpc_cidr
}