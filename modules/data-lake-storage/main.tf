data "azurerm_client_config" "current" {}

resource "azurerm_storage_account" "this" {
  name                     = "stingdl${var.brand}${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true

  public_network_access_enabled = true 

   network_rules {
    default_action = "Deny"
    ip_rules       = ["49.36.188.5"]
    bypass         = ["AzureServices"]
  }

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }

}


resource "azurerm_storage_container" "historical-data" {
  name                  = "historical-data"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "storage_blob_contributor" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_private_endpoint" "storage_account" {
  name                = "pe-sa-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "psc-sa-ing-${var.brand}-${var.environment}"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["dfs"]
    is_manual_connection           = false
  }
}
