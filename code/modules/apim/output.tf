output "id" {
  value = azurerm_api_management.api_management.id
}

output "name" {
  value = azurerm_api_management.api_management.name
}

output "private_ip_addresses" {
  value = azurerm_api_management.api_management.private_ip_addresses
}

output "gateway_url" {
  value = azurerm_api_management.api_management.gateway_url
}

output "gateway_hostname" {
  value = regex("https?://([\\d\\w\\-\\.]+)", azurerm_api_management.api_management.gateway_url)[0]
}

output "tenant_id" {
  value = azurerm_api_management.api_management.identity[0].tenant_id
}

output "principal_id" {
  value = azurerm_api_management.api_management.identity[0].principal_id
}
