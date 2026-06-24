resource "azurerm_public_ip" "this" {
  name                = "pip-jumpbox-ing-${var.brand}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

}

resource "azurerm_network_interface" "nic" {
  name                = "nic-jumpbox-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "pip"
    subnet_id                     = var.aks_subnet_id
    public_ip_address_id          = azurerm_public_ip.this.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "lvm" {
  name                = "vm-jumpbox-ing-${var.brand}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username = "azureuser"
  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  source_image_reference {

    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"

  }

  network_interface_ids = [azurerm_network_interface.nic.nic_id]

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}
