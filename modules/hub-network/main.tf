resource "azurerm_virtual_network" "this" {
  name                = "vnet-ing-gbl-core"
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}


resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.address_prefixes]

  #address_prefixes     = ["10.0.0.0/26"]
}


resource "azurerm_public_ip" "pip" {
  name                = "pip-ing-gbl-core"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall-hub" {
  name                = "fw-ing-gbl-core"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.subnet_id
    public_ip_address_id = azurerm_public_ip.pip_id
  }
}
