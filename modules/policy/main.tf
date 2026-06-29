resource "azurerm_policy_definition" "this" {
  name         = var.policy_name
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = var.display_name

  policy_rule = var.policy_rule
}

resource "azurerm_subscription_policy_assignment" "this" {
  name                 = "${var.policy_name}-assignment"
  policy_definition_id = azurerm_policy_definition.this.id
  subscription_id      = "/subscriptions/${var.subscription_id}"
}