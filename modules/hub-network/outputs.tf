output "id" {
  value = azurerm_virtual_network.this.id
}

output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "resource_group_name" {
  value = azurerm_resource_group.gbl_rg.name
}

output "pip_id" {
    value = azurerm_public_ip.pip.id
}


output "firewall_subnet_id" {
    value = azurerm_subnet.firewall_subnet.id
}


output "firewall_private_ip" {
  value = azurerm_firewall.firewall-hub.ip_configuration[0].private_ip_address
}


