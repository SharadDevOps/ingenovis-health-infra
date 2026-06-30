resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku

  admin_enabled                 = false
  public_network_access_enabled = true
  
  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}


resource "azurerm_private_endpoint" "acr" {
  name                = "${var.acr_name}-pe"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "${var.acr_name}-psc"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
}

