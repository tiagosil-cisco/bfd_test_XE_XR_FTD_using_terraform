
module "iosxe" {
  source = "./modules/iosxe"
}

module "iosxr" {
  source = "./modules/iosxr"
}

module "fmc" {
  depends_on = [module.iosxe, module.iosxr]
  source     = "./modules/fmc"
}

