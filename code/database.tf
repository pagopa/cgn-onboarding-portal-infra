resource "azurerm_resource_group" "rg_db" {
  name     = format("%s-db-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_postgresql_server" "postgresql_server" {
  name                = format("%s-db-postgresql", local.project)
  location            = azurerm_resource_group.rg_db.location
  resource_group_name = azurerm_resource_group.rg_db.name

  administrator_login          = data.azurerm_key_vault_secret.db_administrator_login.value
  administrator_login_password = data.azurerm_key_vault_secret.db_administrator_login_password.value

  sku_name   = var.db_sku_name
  version    = var.db_version
  storage_mb = var.db_storage_mb

  auto_grow_enabled = var.db_auto_grow_enabled

  public_network_access_enabled    = var.db_public_network_access_enabled
  ssl_enforcement_enabled          = var.db_ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.db_ssl_minimal_tls_version_enforced

  tags = var.tags

}

/*
resource "azurerm_postgresql_virtual_network_rule" "postgresql_virtual_network_rule" {
  count                                = contains(split("", var.db_sku_name), "B") ? 0 : 1
  name                                 = format("%s-postgresql-vnet-rule", local.project)
  resource_group_name                  = azurerm_resource_group.rg_db.name
  server_name                          = azurerm_postgresql_server.postgresql_server.name
  subnet_id                            = module.subnet_db.id
  ignore_missing_vnet_service_endpoint = true

}
*/

resource "azurerm_postgresql_database" "postgresql_database" {
  name                = var.database_name
  resource_group_name = azurerm_resource_group.rg_db.name
  server_name         = azurerm_postgresql_server.postgresql_server.name
  charset             = var.db_charset
  collation           = var.db_collation
}

resource "azurerm_private_endpoint" "postgresql_private_endpoint" {
  name                = format("%s-db-private-endpoint", local.project)
  location            = azurerm_resource_group.rg_db.location
  resource_group_name = azurerm_resource_group.rg_db.name
  subnet_id           = module.subnet_db.id

  private_dns_zone_group {
    name                 = format("%s-db-private-dns-zone-group", local.project)
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_postgres.id]
  }

  private_service_connection {
    name                           = format("%s-db-private-service-connection", local.project)
    private_connection_resource_id = azurerm_postgresql_server.postgresql_server.id
    is_manual_connection           = false
    subresource_names              = ["postgreSqlServer"]
  }
}

resource "azurerm_private_dns_a_record" "private_dns_a_record_postgresql" {
  name                = "postgresql"
  zone_name           = azurerm_private_dns_zone.private_dns_zone_postgres.name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = 300
  records             = azurerm_private_endpoint.postgresql_private_endpoint.private_service_connection.*.private_ip_address
}
