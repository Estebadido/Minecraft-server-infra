module "vpc" {
  source      = "./modules/vpc"
  region      = var.region
  tags        = local.tags
}
module "ec2" {
  source      = "./modules/ec2"
  region      = var.region
  tags        = local.tags
}
module "sg" {
  source = "./modules/sg"
  tags   = local.tags
}