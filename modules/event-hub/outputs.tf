output "namespace_id" {
  description = "Event Hub namespace ID - needed for diagnostics and monitoring"
  value       = azurerm_eventhub_namespace.this.id
}

output "namespace_name" {
  description = "Event Hub namespace name"
  value       = azurerm_eventhub_namespace.this.name
}

output "candidates_eventhub_name" {
  description = "Name of the candidates event hub - AKS matching service consumes from this"
  value       = azurerm_eventhub.candidates.name
}

output "job_orders_eventhub_name" {
  description = "Name of the job orders event hub - AKS matching service consumes from this"
  value       = azurerm_eventhub.job_orders.name
}