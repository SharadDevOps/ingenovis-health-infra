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
  depends_on                  = [module.networking]
  source                      = "../../../modules/key-vault"
  resource_group_name         = module.resource_group.name
  brand                       = var.brand
  environment                 = var.environment
  location                    = var.location
  private_endpoints_subnet_id = module.networking.private_endpoints_subnet_id
  uami_principal_id           = module.identity.principal_id

}

module "data_lake_storage" {
  depends_on                  = [module.event_hub]
  source                      = "../../../modules/data-lake-storage"
  resource_group_name         = module.resource_group.name
  brand                       = var.brand
  environment                 = var.environment
  location                    = var.location
  private_endpoints_subnet_id = module.networking.private_endpoints_subnet_id
}

module "event_hub" {
  depends_on                  = [module.keyvault]
  source                      = "../../../modules/event-hub"
  resource_group_name         = module.resource_group.name
  brand                       = var.brand
  environment                 = var.environment
  location                    = var.location
  private_endpoints_subnet_id = module.networking.private_endpoints_subnet_id
}


module "azure_openai" {
  depends_on                  = [module.cosmos_db]
  source                      = "../../../modules/azure-openai"
  resource_group_name         = module.resource_group.name
  brand                       = var.brand
  environment                 = var.environment
  location                    = var.location
  private_endpoints_subnet_id = module.networking.private_endpoints_subnet_id
}

module "cosmos_db" {
  depends_on                  = [module.data_lake_storage]
  source                      = "../../../modules/cosmos-db"
  resource_group_name         = module.resource_group.name
  brand                       = var.brand
  environment                 = var.environment
  location                    = var.location
  private_endpoints_subnet_id = module.networking.private_endpoints_subnet_id
}

module "ai_search" {
  depends_on                  = [module.azure_openai]
  source                      = "../../../modules/ai-search"
  resource_group_name         = module.resource_group.name
  brand                       = var.brand
  environment                 = var.environment
  location                    = var.location
  private_endpoints_subnet_id = module.networking.private_endpoints_subnet_id
}

module "acr" {
  depends_on                  = [module.ai_search]
  source                      = "../../../modules/acr"
  resource_group_name         = module.resource_group.name
  brand                       = var.brand
  environment                 = var.environment
  location                    = var.location
  acr_name                    = var.acr_name
  acr_sku                     = var.acr_sku
  private_endpoints_subnet_id = module.networking.private_endpoints_subnet_id
}

module "aks" {
  source                      = "../../../modules/aks"
  resource_group_name         = module.resource_group.name
  brand                       = var.brand
  environment                 = var.environment
  location                    = var.location
  aks_subnet_id               = module.networking.aks_subnet_id
  private_endpoints_subnet_id = module.networking.private_endpoints_subnet_id
  uami_id                     = module.identity.id
  acr_id                      = module.acr.id
}

module "flux" {
  source            = "../../../modules/flux"
  github_owner      = var.github_owner
  github_repository = var.github_repository
  github_token      = var.github_token

  depends_on = [module.aks]
}
