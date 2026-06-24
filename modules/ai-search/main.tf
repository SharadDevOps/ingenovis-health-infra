resource "azurerm_search_service" "this" {
  name                = "ais-ing-${var.brand}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "basic"
  partition_count     = 1
  replica_count       = 1

  public_network_access_enabled = false

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_private_endpoint" "ai_searchservice" {
  name                = "pe-ais-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "psc-ais-ing-${var.brand}-${var.environment}"
    private_connection_resource_id = azurerm_search_service.this.id
    subresource_names              = ["searchService"]
    is_manual_connection           = false
  }
}