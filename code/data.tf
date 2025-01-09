data "azurerm_virtual_network" "itn" {
  name                = "io-${var.env_short}-itn-cgn-pe-vnet-01"
  resource_group_name = "io-${var.env_short}-itn-cgn-pe-rg-01"
}