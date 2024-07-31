# monitor
output "law_workpace_id" {
  value = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

output "ai_instrumentation_key" {
  value     = azurerm_application_insights.application_insights.instrumentation_key
  sensitive = true
}

output "ai_app_id" {
  value = azurerm_application_insights.application_insights.app_id
}

# container registry
output "acr_login_server" {
  value = azurerm_container_registry.container_registry.login_server

}

# web app service
output "web_app_1_default_host_name" {
  value = module.portal_backend_1.default_site_hostname
}

# database postgres
output "db_administrator_login" {
  value     = data.azurerm_key_vault_secret.db_administrator_login.value
  sensitive = true
}

output "db_fqdn" {
  value = azurerm_postgresql_server.postgresql_server.fqdn
}


# external
output "api_gateway_public_id" {
  value = azurerm_public_ip.apigateway_public_ip.ip_address
}