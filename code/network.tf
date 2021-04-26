resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

## Network security groups:
### database
resource "azurerm_network_security_group" "db_nsg" {
  name                = format("%s-db-nsg", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name

  /* TODO: create network security rules.
  security_rule {
    name                       = "allow"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  */

  tags = var.tags

}

resource "azurerm_virtual_network" "vnet" {
  name                = format("%s-vnet", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_vnet

  tags = var.tags

}

module "subnet_db" {
  source                                         = "./modules/subnet"
  name                                           = format("%s-db-subnet", local.project)
  address_prefixes                               = var.cidr_subnet_db
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  service_endpoints                              = ["Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true
}

module "subnet_api" {
  source               = "./modules/subnet"
  name                 = format("%s-api-subnet", local.project)
  address_prefixes     = var.cidr_subnet_api
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  delegation = {
    name = "default"

    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  service_endpoints = [
    "Microsoft.Web"
  ]

}

module "subnet_public" {
  source               = "./modules/subnet"
  name                 = format("%s-fe-public", local.project)
  address_prefixes     = var.cidr_subnet_public
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}


resource "azurerm_private_dns_zone" "private_dns_zone_postgres" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg_vnet.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  name                  = format("%s-private-dns-zone-link", local.project)
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_postgres.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_public_ip" "apigateway_public_ip" {
  name                = format("%s-apigateway-pip", local.project)
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name
  location            = azurerm_virtual_network.vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

# APIM subnet

resource "azurerm_subnet" "subnet_apim" {
  name                 = format("%s-apim-subnet", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.cidr_subnet_apim

  service_endpoints = ["Microsoft.Web"]

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_private_dns_zone" "api_private_dns_zone" {
  name                = var.apim_private_domain
  resource_group_name = azurerm_resource_group.rg_vnet.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "api_private_dns_zone_virtual_network_link" {
  name                  = format("%s-api-private-dns-zone-link", local.project)
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.api_private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_a_record" "private_dns_a_record_api" {
  name                = local.apim_name
  zone_name           = azurerm_private_dns_zone.api_private_dns_zone.name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = 300
  records             = module.apim.*.private_ip_addresses[0]
}
