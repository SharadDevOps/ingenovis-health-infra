module "resource_group" {
  source      = "../../../modules/resource-group"
  name        = "rg-ing-${var.brand}-${var.environment}"
  location    = var.location
  brand       = var.brand
  environment = var.environment
}

module "networking" {
  source                          = "../../../modules/networking"
  resource_group_name             = module.resource_group.name
  brand                           = var.brand
  environment                     = var.environment
  location                        = var.location
  vnet_address_space              = var.vnet_address_space
  storage_subnet_prefix           = var.storage_subnet_prefix
  private_endpoints_subnet_prefix = var.private_endpoints_subnet_prefix
  aks_subnet_prefix               = var.aks_subnet_prefix
}

module "identity" {
  source      = "../../../modules/identity"
  brand       = var.brand
  environment = var.environment
  location    = var.location

  resource_group_name = module.resource_group.name
  resource_group_id   = module.resource_group.id
}


module "keyvault" {
  source                      = "../../../modules/key-vault"
  resource_group_name         = module.resource_group.name
  brand                       = var.brand
  environment                 = var.environment
  location                    = var.location
  private_endpoints_subnet_id = module.networking.private_endpoints_subnet_id
  uami_principal_id           = module.identity.principal_id

}



