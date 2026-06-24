resource "azure_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku               = var.acr_sku

  admin_enabled                 = true
  public_network_access_enabled = false
  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}

