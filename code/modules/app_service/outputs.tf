output "name" {
  value = azurerm_app_service.app_service.name
}

output "plan_name" {
  value = azurerm_app_service_plan.app_service_plan.name
}

output "default_site_hostname" {
  value = azurerm_app_service.app_service.default_site_hostname
}

output "principal_id" {
  value = azurerm_app_service.app_service.identity[0].principal_id
}
