module "network" {
  source   = "./network"
  app_name = var.app_name
}

module "acm" {
  source = "./acm"
  domain = var.domain
}
