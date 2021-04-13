resource "azurerm_resource_group" "rg_api" {
  name     = format("%s-api-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_container_registry" "container_registry" {
  name                = join("", [replace(var.prefix, "-", ""), var.env_short, "arc"])
  resource_group_name = azurerm_resource_group.rg_api.name
  location            = azurerm_resource_group.rg_api.location
  sku                 = var.sku_container_registry
  # TODO?
  #admin_enabled       = true


  dynamic "retention_policy" {
    for_each = var.sku_container_registry == "Premium" ? [var.retention_policy_acr] : []
    content {
      days    = retention_policy.value["days"]
      enabled = retention_policy.value["enabled"]
    }
  }

  tags = var.tags
}

# TODO https://github.com/pagopa/cgn-onboarding-portal-backend website api backend


# TODO search api
