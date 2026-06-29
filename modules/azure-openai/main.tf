
resource "azurerm_cognitive_account" "this" {
  name                = "aoi-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "OpenAI"

  public_network_access_enabled = false

  custom_subdomain_name = "aoi-ing-${var.brand}-${var.environment}"

  sku_name = "S0"

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_cognitive_deployment" "gpt4o_mini" {
  name                 = "gpt-4-1-nano"
  cognitive_account_id = azurerm_cognitive_account.this.id

  model {
    format  = "OpenAI"
    name    = "gpt-4.1-nano"
    version = "2025-04-14"
  }

  scale {
    capacity = 1
    type     = "GlobalStandard"
  }
}



resource "azurerm_private_endpoint" "openai" {
  name                = "pe-aoi-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }


  private_service_connection {
    name                           = "psc-aoi-ing-${var.brand}-${var.environment}"
    private_connection_resource_id = azurerm_cognitive_account.this.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }
}
