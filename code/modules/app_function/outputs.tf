output "id" {
  value       = azurerm_function_app.this.id
  description = "Function app id."
}

output "name" {
  value       = azurerm_function_app.this.name
  description = "Function app name."
}

output "plan_id" {
  value       = azurerm_app_service_plan.this.id
  description = "Function app plan id"
}

output "plan_name" {
  value       = azurerm_app_service_plan.this.name
  description = "Function app plan name."
}