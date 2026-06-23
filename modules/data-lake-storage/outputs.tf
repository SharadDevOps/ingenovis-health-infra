output "storage_account_id" {
  description = "Storage account ID - needed for diagnostics and access policies"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Storage account name - AKS matching pipeline reads historical data from here"
  value       = azurerm_storage_account.this.name
}

output "container_name" {
  description = "Name of the historical data container - Databricks batch load target"
  value       = azurerm_storage_container.historical-data.name
}