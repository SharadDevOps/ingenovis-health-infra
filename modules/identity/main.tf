resource "azurerm_user_assigned_identity" "this" {
  name                = "uami-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Scoped role assignment - this identity gets Contributor ONLY on its own
# resource group, never on the subscription. This is what makes "separate
# UAMI per environment" actually mean something: even though Trustaff Dev
# and Trustaff Prod might share a subscription today, this identity's
# Contributor role is scoped to ITS resource group only.
resource "azurerm_role_assignment" "contributor_scoped_to_rg" {
  scope                = var.resource_group_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}
