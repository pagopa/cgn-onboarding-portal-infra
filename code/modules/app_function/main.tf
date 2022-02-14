
resource "azurerm_app_service_plan" "this" {
  name                = format("%s-plan", var.name)
  location            = var.location
  resource_group_name = var.resource_group_name

  kind     = var.plan_info.kind
  reserved = true

  sku {
    tier = var.plan_info.sku_tier
    size = var.plan_info.sku_size
  }

  tags = var.tags
}

resource "azurerm_storage_account" "this" {
  name                     = replace(format("st-%s", var.name), "-", "")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = var.tags
}

locals {
  allowed_ips     = [for ip in var.allowed_ips : { ip_address = ip, virtual_network_subnet_id = null }]
  allowed_subnets = [for s in var.allowed_subnets : { ip_address = null, virtual_network_subnet_id = s }]
  ip_restrictions = concat(local.allowed_subnets, local.allowed_ips)
}


resource "azurerm_function_app" "this" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  version                    = var.runtime_version
  os_type                    = var.os_type
  app_service_plan_id        = azurerm_app_service_plan.this.id
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  #tfsec:ignore:AZU028
  https_only = false

  site_config {
    min_tls_version           = "1.2"
    ftps_state                = "Disabled"
    pre_warmed_instance_count = var.pre_warmed_instance_count
    vnet_route_all_enabled    = var.subnet_id == null ? false : true

    dynamic "ip_restriction" {
      for_each = local.ip_restrictions
      iterator = ip

      content {
        ip_address                = ip.value.ip_address
        virtual_network_subnet_id = ip.value.virtual_network_subnet_id
      }
    }

    dynamic "cors" {
      for_each = var.cors != null ? [var.cors] : []
      content {
        allowed_origins = cors.value.allowed_origins
      }
    }

    health_check_path = var.health_check_path != null ? var.health_check_path : null

  }

  app_settings = merge(
    {
      APPINSIGHTS_INSTRUMENTATIONKEY = var.application_insights_instrumentation_key
      # No downtime on slots swap
      WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = 1
      # default value for health_check_path, override it in var.app_settings if needed
      WEBSITE_HEALTHCHECK_MAXPINGFAILURES = var.health_check_path != null ? var.health_check_maxpingfailures : null
    },
    var.app_settings
  )

  enable_builtin_logging = false

  tags = var.tags

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_CONTENTSHARE"],
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  count = var.subnet_name != null ? 1 : 0

  app_service_id = azurerm_function_app.this.id
  subnet_id      = var.subnet_id
}

resource "azurerm_function_app_slot" "slot" {
  count                      = var.slot_name != null ? 1 : 0
  name                       = var.slot_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  version                    = var.runtime_version
  os_type                    = var.os_type
  function_app_name          = azurerm_function_app.this.name
  app_service_plan_id        = azurerm_app_service_plan.this.id
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key

  #tfsec:ignore:AZU028
  https_only = false

  site_config {
    min_tls_version           = "1.2"
    ftps_state                = "Disabled"
    pre_warmed_instance_count = var.pre_warmed_instance_count
    vnet_route_all_enabled    = var.subnet_id == null ? false : true

    dynamic "ip_restriction" {
      for_each = local.ip_restrictions
      iterator = ip

      content {
        ip_address                = ip.value.ip_address
        virtual_network_subnet_id = ip.value.virtual_network_subnet_id
      }
    }

    dynamic "cors" {
      for_each = var.cors != null ? [var.cors] : []
      content {
        allowed_origins = cors.value.allowed_origins
      }
    }

    health_check_path = var.health_check_path != null ? var.health_check_path : null

  }

  app_settings = merge(
    {
      APPINSIGHTS_INSTRUMENTATIONKEY = var.application_insights_instrumentation_key
      # No downtime on slots swap
      WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = 1
      # default value for health_check_path, override it in var.app_settings if needed
      WEBSITE_HEALTHCHECK_MAXPINGFAILURES = var.health_check_path != null ? var.health_check_maxpingfailures : null
    },
    var.app_settings_slot
  )

  enable_builtin_logging = false

  tags = var.tags

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_CONTENTSHARE"],
    ]
  }
}

resource "azurerm_app_service_slot_virtual_network_swift_connection" "app_service_slot_virtual_network_swift_connection" {
  count          = (var.subnet_id == null && var.slot_name != null) ? 1 : 0
  app_service_id = azurerm_function_app.this.id
  subnet_id      = var.subnet_id
  slot_name      = azurerm_function_app_slot.slot[0].name
}
