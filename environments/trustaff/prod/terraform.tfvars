brand       = "trustaff"
environment = "prd"
location    = "eastus"

# From IP-ADDRESS-PLAN.md - Trustaff Prod block
vnet_address_space              = "10.22.16.0/20"
aks_subnet_prefix                = "10.22.16.0/24"
storage_subnet_prefix            = "10.22.17.0/24"
private_endpoints_subnet_prefix  = "10.22.18.0/27"

# Subscription - currently all 3 brands point at the same free-tier subscription
# (see decision log: real per-brand subscriptions deferred until budget approved)
