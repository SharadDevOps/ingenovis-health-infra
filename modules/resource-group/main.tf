resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
    project     = "ingenovis-ai-matching"
  }
}
