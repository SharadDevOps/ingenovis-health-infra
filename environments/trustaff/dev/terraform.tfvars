brand       = "trustaff"
environment = "dev"
location    = "eastus"

# From IP-ADDRESS-PLAN.md - Trustaff Dev block
vnet_address_space              = "10.20.16.0/20"
aks_subnet_prefix                = "10.20.16.0/24"
storage_subnet_prefix            = "10.20.17.0/24"
private_endpoints_subnet_prefix  = "10.20.18.0/27"

# Subscription - currently all 3 brands point at the same free-tier subscription
# (see decision log: real per-brand subscriptions deferred until budget approved)


client_id      = "4f612313-8857-4123-ab69-5256bce932d5"
subscription_id = "c03c17da-b041-4ca5-854f-df714e780928"
tenant_id        = "f3e7c0d1-4b8a-4f5e-9c2b-1a2b3c4d5e6f"