resource "azurerm_cosmosdb_account" "this" {
  name                = "cdb-ing-${var.brand}-${var.environment}"
  location            = "eastus2"
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  public_network_access_enabled = false

  automatic_failover_enabled = true


  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = "eastus2"
    failover_priority = 0
    zone_redundant    = false
  }

  capabilities {
    name = "EnableServerless"
  }

  tags = {
    brand       = var.brand
    environment = var.environment
    managed_by  = "terraform"
  }

}

resource "azurerm_cosmosdb_sql_database" "this" {
  name                = "ingenovis-matching"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
}


resource "azurerm_cosmosdb_sql_container" "candidates" {
  name                = "container-ing-${var.brand}-${var.environment}-candidates"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  database_name       = azurerm_cosmosdb_sql_database.this.name

  partition_key_paths = ["/candidateId"]
 
  unique_key {
    paths = ["/uniqueKey"]
  }
}

resource "azurerm_cosmosdb_sql_container" "job-orders" {
  name                = "container-ing-${var.brand}-${var.environment}-job-orders"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  database_name       = azurerm_cosmosdb_sql_database.this.name
  

  partition_key_paths = ["/jobOrderId"]

  unique_key {
    paths = ["/uniqueKey"]
  }
}

resource "azurerm_cosmosdb_sql_container" "matches" {
  name                = "container-ing-${var.brand}-${var.environment}-matches"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  database_name       = azurerm_cosmosdb_sql_database.this.name


  partition_key_paths = ["/matchid"]

  unique_key {
    paths = ["/uniqueKey"]
  }
}

resource "azurerm_private_endpoint" "cosmosdb" {
  name                = "pe-cdb-ing-${var.brand}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "psc-cdb-ing-${var.brand}-${var.environment}"
    private_connection_resource_id = azurerm_cosmosdb_account.this.id
    subresource_names              = ["Sql"]
    is_manual_connection           = false
  }
}
