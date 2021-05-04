module "redis_cache" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=main"
  name                  = format("%s-apim", local.project)
  resource_group_name   = azurerm_resource_group.rg_db.name
  location              = azurerm_resource_group.rg_db.location
  capacity              = 1
  enable_non_ssl_port   = false
  family                = var.redis_cache_family
  sku_name              = var.redis_cache_sku_name
  enable_authentication = true

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
