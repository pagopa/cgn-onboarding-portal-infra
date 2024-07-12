module "redis_cache" {
  # "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v2.0.26"
  source                = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v8.26.5"
  name                  = format("%s-apim", local.project)
  resource_group_name   = azurerm_resource_group.rg_db.name
  location              = azurerm_resource_group.rg_db.location
  capacity              = 1
  enable_non_ssl_port   = false
  family                = var.redis_cache_family
  sku_name              = var.redis_cache_sku_name
  enable_authentication = true
  zones                 = []
  redis_version         = "6"

  private_endpoint = {
    enabled              = true
    virtual_network_id   = azurerm_virtual_network.vnet.id
    subnet_id            = module.subnet_redis.id
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_redis_cache_windows_net.id]
  }

  patch_schedules = [{
    day_of_week    = "Sunday"
    start_hour_utc = 23
    },
    {
      day_of_week    = "Monday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Tuesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Wednesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Thursday"
      start_hour_utc = 23
    },
  ]

  tags = var.tags
}
