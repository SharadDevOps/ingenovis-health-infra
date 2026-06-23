resource "azurerm_resource_group" "example" {
  name     = var.name
  location = var.location

  tags = {
    brand       = var.brand
    environment = var.environment
  }
}

