module "network" {
  source   = "./network"
  app_name = var.app_name
}

module "acm" {
  source = "./acm"
  domain = var.domain
}

module "spa" {
  source   = "./spa"
  app_name = var.app_name
  domain   = var.domain
  acm_id   = module.acm.acm_id
}
