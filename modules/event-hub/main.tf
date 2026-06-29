resource "azurerm_eventhub_namespace" "this" {
  name                = "evhns-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1

  public_network_access_enabled = false

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_eventhub" "candidates" {
  name                = "eh-candidates"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_eventhub_namespace.this.name
  partition_count     = 2
  message_retention   = 1

}


resource "azurerm_eventhub" "job_orders" {
  name                = "eh-job-orders"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_eventhub_namespace.this.name
  partition_count     = 2
  message_retention   = 1
}


resource "azurerm_private_endpoint" "event_hub" {
  name                = "pe-evh-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "psc-evh-ing-${var.brand}-${var.environment}"
    private_connection_resource_id = azurerm_eventhub_namespace.this.id
    subresource_names              = ["namespace"]
    is_manual_connection            = false
  }

   tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_eventhub_consumer_group" "candidates" {
  name                = "cg-matching-pipeline"
  namespace_name      = azurerm_eventhub_namespace.this.name
  eventhub_name       = azurerm_eventhub.candidates.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "job_orders" {
  name                = "cg-matching-pipeline"
  namespace_name      = azurerm_eventhub_namespace.this.name
  eventhub_name       = azurerm_eventhub.job_orders.name
  resource_group_name = var.resource_group_name
}
