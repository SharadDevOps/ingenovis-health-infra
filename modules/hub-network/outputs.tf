output "id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_id" {
    value = azurerm_subnet.firewall_subnet.id
}

output "pip_id" {
    value = azurerm_public_ip.pip.id
}


output "firewall_subnet_id" {
    value = azurerm_firewall.firewall-hub.id   # this outputs the FIREWALL's id, not the subnet
}


output "firewall_private_ip" {
  value = azurerm_firewall.firewall-hub.ip_configuration[0].private_ip_address
}

