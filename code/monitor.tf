resource "azurerm_resource_group" "monitor_rg" {
  name     = format("%s-monitor-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = format("%s-law", local.project)
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_in_days
  daily_quota_gb      = var.law_daily_quota_gb

  tags = var.tags
}

# Application insights
resource "azurerm_application_insights" "application_insights" {
  name                = format("%s-app-insights", local.project)
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  application_type    = "other"

  tags = var.tags
}


resource "azurerm_monitor_action_group" "p0action" {
  name                = "CriticalAlertsAction"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "p0action"

  email_receiver {
    name                    = "support"
    email_address           = var.devops_admin_email
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_metric_alert" "backend_5xx" {
  name                = format("%s-%s", module.portal_backend_1.name, "5xx")
  resource_group_name = azurerm_resource_group.monitor_rg.name
  scopes              = [module.portal_backend_1.id]
  severity            = 1
  frequency           = "PT1M"
  window_size         = "PT5M"

  action {
    action_group_id = azurerm_monitor_action_group.p0action.id
  }

  criteria {
    aggregation      = "Count"
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    operator         = "GreaterThanOrEqual"
    threshold        = "10"
  }

  tags = var.tags
}



########################################
# PostgreSQL
########################################

resource "azurerm_monitor_metric_alert" "postgresql_server" {
  for_each = var.db_monitor_metric_alert_criteria

  name                = format("%s-%s", azurerm_postgresql_server.postgresql_server.name, upper(each.key))
  resource_group_name = azurerm_resource_group.monitor_rg.name
  scopes              = [azurerm_postgresql_server.postgresql_server.id]
  frequency           = each.value.frequency
  window_size         = each.value.window_size

  action {
    action_group_id = azurerm_monitor_action_group.p0action.id
  }

  criteria {
    aggregation      = each.value.aggregation
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    metric_name      = each.value.metric_name
    operator         = each.value.operator
    threshold        = each.value.threshold

    dynamic "dimension" {
      for_each = each.value.dimension
      content {
        name     = dimension.value.name
        operator = dimension.value.operator
        values   = dimension.value.value
      }
    }
  }

  tags = var.tags
}

#
# Alerts
#
resource "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = azurerm_resource_group.monitor_rg.name
  name                = "cgn${var.env_short}error"
  short_name          = "cgn${var.env_short}error"

  email_receiver {
    name                    = "email"
    email_address           = data.azurerm_key_vault_secret.alert_error_notification_email.value
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "slack"
    email_address           = data.azurerm_key_vault_secret.alert_error_notification_slack.value
    use_common_alert_schema = true
  }

  tags = var.tags
}