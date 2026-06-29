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
    value = azurerm_firewall.firewall-hub.id
}

output "firewall_private_ip" {
  value = azurerm_firewall.firewall-hub.private_ip_ranges
}

