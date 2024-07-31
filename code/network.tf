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

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan == null ? [] : ["dummy"]

    content {
      id     = var.ddos_protection_plan.id
      enable = var.ddos_protection_plan.enable
    }
  }

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

module "subnet_redis" {
  source                                         = "./modules/subnet"
  name                                           = format("%s-redis-subnet", local.project)
  address_prefixes                               = var.cidr_subnet_redis
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
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
    "Microsoft.Web",
    "Microsoft.Storage",
    "Microsoft.Sql",
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

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  name                  = format("%s-private-dns-zone-link", local.project)
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_postgres.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone" "privatelink_redis_cache_windows_net" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_redis_cache_windows_net_vnet" {
  name                  = azurerm_virtual_network.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache_windows_net.name
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

module "subnet_spid_login" {
  source               = "./modules/subnet"
  name                 = format("%s-spidlogin-subnet", local.project)
  address_prefixes     = var.cidr_subnet_spid_login
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
    "Microsoft.Web",
    "Microsoft.Storage",
    "Microsoft.Sql",
  ]
}

module "subnet_ade_aa_mock" {
  source               = "./modules/subnet"
  count                = (var.enable_ade_aa_mock && var.cidr_subnet_ade_aa_mock != null) ? 1 : 0
  name                 = format("%s-ade-aa-mock-subnet", local.project)
  address_prefixes     = var.cidr_subnet_ade_aa_mock
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
    "Microsoft.Web",
    "Microsoft.Storage",
    "Microsoft.Sql",
  ]

}



module "subnet_function" {
  source               = "./modules/subnet"
  name                 = format("%s-function-subnet", local.project)
  address_prefixes     = var.cidr_subnet_function
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
    "Microsoft.Web",
    "Microsoft.Storage",
    "Microsoft.Sql",
  ]
}

module "subnet_function_operator_search" {
  source               = "./modules/subnet"
  name                 = format("%s-function-operator-search", local.project)
  address_prefixes     = var.cidr_subnet_function_operator_search
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
    "Microsoft.Web",
    "Microsoft.Storage",
    "Microsoft.Sql",
  ]
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
  ttl                 = 10
  records             = module.apim.*.private_ip_addresses[0]
}

data "azurerm_api_management" "apim_v2" {
  name                = "${local.apim_name}-v2"
  resource_group_name = azurerm_resource_group.rg_api.name
}

data "azurerm_subnet" "subnet_apim_v2" {
  name                 = format("%s-api-subnet-v2", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

locals {
  # For UAT migration:
  # If is UAT replace private A record with custom domain built in
  # Then add "p" for PROD migration
  # At the end delete the resource azurerm_private_dns_a_record.private_dns_a_record_api and make this configuration as default

  apim_v2_custom_domain = replace(data.azurerm_api_management.apim_v2.gateway_url, "https://", "")
  apim_hostname         = contains(["u", "p"], var.env_short) ? local.apim_v2_custom_domain : trim(azurerm_private_dns_a_record.private_dns_a_record_api.fqdn, ".")
}