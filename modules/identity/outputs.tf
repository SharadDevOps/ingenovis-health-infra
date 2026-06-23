output "principal_id" {
  description = "Object ID of the UAMI - used to grant this identity access to other resources like Key Vault"
  value       = azurerm_user_assigned_identity.this.principal_id
}

output "client_id" {
  description = "Client ID of the UAMI - used when configuring workloads (e.g. AKS pods) to authenticate as this identity"
  value       = azurerm_user_assigned_identity.this.client_id
}

output "id" {
  value = azurerm_user_assigned_identity.this.id
}
