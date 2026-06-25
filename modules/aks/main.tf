resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name


  private_cluster_enabled = false
  oidc_issuer_enabled     = true
  dns_prefix              = "aks-ing-${var.brand}-${var.environment}"

  default_node_pool {
    name            = "system"
    node_count      = 1
    vm_size         = "Standard_D4s_v7"
    vnet_subnet_id  = var.aks_subnet_id
    os_disk_size_gb = 30
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.uami_id]
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}


resource "azurerm_role_assignment" "acr_pull" {

  role_definition_name = "AcrPull"
  scope                = var.acr_id
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id

}
