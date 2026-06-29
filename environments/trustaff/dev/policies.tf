# Policy Definitions

module "policy_require_tag" {
  source           = "../../../modules/policy"
  policy_name      = "require-brand-tag"
  display_name     = "Require brand tag on all resources"
  subscription_id  = var.subscription_id

  policy_rule = jsonencode({
    if = {
      field  = "tags['brand']"
      exists = "false"
    }
    then = { effect = "Audit" }
  })
}


module "policy_deny_public_access" {
  source           = "../../../modules/policy"
  policy_name      = "deny-public-network-access"
  display_name     = "Deny public network access on storage and key vault"
  subscription_id  = var.subscription_id

  policy_rule = jsonencode({
    if = {
      anyOf = [
        {
          allOf = [
            { field = "type", equals = "Microsoft.Storage/storageAccounts" },
            { field = "Microsoft.Storage/storageAccounts/publicNetworkAccess", notEquals = "Disabled" }
          ]
        },
        {
          allOf = [
            { field = "type", equals = "Microsoft.KeyVault/vaults" },
            { field = "Microsoft.KeyVault/vaults/publicNetworkAccess", notEquals = "Disabled" }
          ]
        }
      ]
    }
    then = { effect = "Audit" }
  })
}

module "policy_allowed_locations" {
  source           = "../../../modules/policy"
  policy_name      = "allowed-locations"
  display_name     = "Allow only eastus and eastus2"
  subscription_id  = var.subscription_id

  policy_rule = jsonencode({
    if = {
      not = {
        field = "location"
        in    = ["eastus", "eastus2", "global"]
      }
    }
    then = { effect = "deny" }
  })
}


module "policy_deny_acr_admin" {
  source           = "../../../modules/policy"
  policy_name      = "deny-acr-admin-enabled"
  display_name     = "Deny ACR with admin user enabled"
  subscription_id  = var.subscription_id

  policy_rule = jsonencode({
    if = {
      allOf = [
        { field = "type", equals = "Microsoft.ContainerRegistry/registries" },
        { field = "Microsoft.ContainerRegistry/registries/adminUserEnabled", equals = "true" }
      ]
    }
    then = { effect = "deny" }
  })
}
