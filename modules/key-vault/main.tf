data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                = "kv-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # Per the resource-level guardrails: purge protection + soft delete required
  purge_protection_enabled    = true
  soft_delete_retention_days  = 90

  # RBAC model is default - no legacy access policies, matches "Azure RBAC using UAMI" requirement

  # No public network access - private endpoint only, per the guardrails document
  public_network_access_enabled = false

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_private_endpoint" "key_vault" {
  name                = "pe-kv-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "psc-kv-ing-${var.brand}-${var.environment}"
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
    is_manual_connection            = false
  }
}