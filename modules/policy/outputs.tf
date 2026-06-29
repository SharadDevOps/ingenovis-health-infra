output "id" {
    value = azurerm_policy_definition.this.id
}

output "policy_assignment_id" {
  value = azurerm_subscription_policy_assignment.this.id
}