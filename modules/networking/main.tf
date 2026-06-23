resource "azurerm_virtual_network" "this" {
  name                = "vnet-ing-${var.brand}-${var.environment}"
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Subnet per resource category, per the "Subnet separation at resource category level" requirement
resource "azurerm_subnet" "aks" {
  name                 = "sn-ing-${var.brand}-${var.environment}-aks"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.aks_subnet_prefix]
}

resource "azurerm_subnet" "storage" {
  name                 = "sn-ing-${var.brand}-${var.environment}-strg"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.storage_subnet_prefix]

  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "private_endpoints" {
  name                 = "sn-ing-${var.brand}-${var.environment}-priv"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.private_endpoints_subnet_prefix]

  private_endpoint_network_policies = "Enabled"
}

# One NSG per subnet - "Subnet level NSG's" from the document
resource "azurerm_network_security_group" "aks" {
  name                = "nsg-ing-${var.brand}-${var.environment}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Default deny inbound from internet - explicit allow only what's needed
  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "storage" {
  name                = "nsg-ing-${var.brand}-${var.environment}-strg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "private_endpoints" {
  name                = "nsg-ing-${var.brand}-${var.environment}-priv"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Allow inbound HTTPS from the AKS subnet only - this is the rule that lets
  # AKS-initiated calls to Key Vault / Event Hub private endpoints actually land.
  # Lower priority number = evaluated first, so this is checked before DenyAllInbound below.
  security_rule {
    name                       = "AllowFromAksSubnet"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.aks_subnet_prefix
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate each NSG to its matching subnet
resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks.id
}

resource "azurerm_subnet_network_security_group_association" "storage" {
  subnet_id                 = azurerm_subnet.storage.id
  network_security_group_id = azurerm_network_security_group.storage.id
}

resource "azurerm_subnet_network_security_group_association" "private_endpoints" {
  subnet_id                 = azurerm_subnet.private_endpoints.id
  network_security_group_id = azurerm_network_security_group.private_endpoints.id
}
