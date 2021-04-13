
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.52.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.52.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cdn_portal_frontend"></a> [cdn\_portal\_frontend](#module\_cdn\_portal\_frontend) | ../modules/cdn_endpoint |  |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ../modules/storage_account |  |
| <a name="module_storage_account_website"></a> [storage\_account\_website](#module\_storage\_account\_website) | ../modules/storage_account |  |
| <a name="module_subnet_api"></a> [subnet\_api](#module\_subnet\_api) | ../modules/subnet |  |
| <a name="module_subnet_db"></a> [subnet\_db](#module\_subnet\_db) | ../modules/subnet |  |
| <a name="module_subnet_public"></a> [subnet\_public](#module\_subnet\_public) | ../modules/subnet |  |

## Resources

| Name | Type |
|------|------|
| [azurerm_cdn_profile.cdn_profile_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_profile) | resource |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_network_security_group.db_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_postgresql_database.postgresql_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_database) | resource |
| [azurerm_postgresql_server.postgresql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_postgresql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.private_dns_zone_postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.postgresql_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_cdn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.profile_logos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.user_documents](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_api"></a> [cidr\_subnet\_api](#input\_cidr\_subnet\_api) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_db"></a> [cidr\_subnet\_db](#input\_cidr\_subnet\_db) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_public"></a> [cidr\_subnet\_public](#input\_cidr\_subnet\_public) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet"></a> [cidr\_vnet](#input\_cidr\_vnet) | Network | `list(string)` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the database. | `string` | n/a | yes |
| <a name="input_db_administrator_login"></a> [db\_administrator\_login](#input\_db\_administrator\_login) | The Administrator Login for the PostgreSQL Server. | `string` | n/a | yes |
| <a name="input_db_administrator_login_password"></a> [db\_administrator\_login\_password](#input\_db\_administrator\_login\_password) | The Password associated with the administrator\_login. | `string` | n/a | yes |
| <a name="input_db_sku_name"></a> [db\_sku\_name](#input\_db\_sku\_name) | Specifies the SKU Name for this PostgreSQL Server. | `string` | n/a | yes |
| <a name="input_db_version"></a> [db\_version](#input\_db\_version) | Specifies the version of PostgreSQL to use. | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_db_auto_grow_enabled"></a> [db\_auto\_grow\_enabled](#input\_db\_auto\_grow\_enabled) | Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. | `bool` | `true` | no |
| <a name="input_db_backup_retention_days"></a> [db\_backup\_retention\_days](#input\_db\_backup\_retention\_days) | Backup retention days for the server | `number` | `null` | no |
| <a name="input_db_charset"></a> [db\_charset](#input\_db\_charset) | Specifies the Charset for the PostgreSQL Database | `string` | `"UTF8"` | no |
| <a name="input_db_collation"></a> [db\_collation](#input\_db\_collation) | Specifies the Collation for the PostgreSQL Database. | `string` | `"Italian_Italy.1252"` | no |
| <a name="input_db_create_mode"></a> [db\_create\_mode](#input\_db\_create\_mode) | The creation mode. Can be used to restore or replicate existing servers. | `string` | `"Default"` | no |
| <a name="input_db_public_network_access_enabled"></a> [db\_public\_network\_access\_enabled](#input\_db\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this server. | `bool` | `false` | no |
| <a name="input_db_ssl_enforcement_enabled"></a> [db\_ssl\_enforcement\_enabled](#input\_db\_ssl\_enforcement\_enabled) | Specifies if SSL should be enforced on connections. | `bool` | `true` | no |
| <a name="input_db_ssl_minimal_tls_version_enforced"></a> [db\_ssl\_minimal\_tls\_version\_enforced](#input\_db\_ssl\_minimal\_tls\_version\_enforced) | The mimimun TLS version to support on the sever. | `string` | `"TLS1_2"` | no |
| <a name="input_db_storage_mb"></a> [db\_storage\_mb](#input\_db\_storage\_mb) | Max storage allowed for a server. | `number` | `5120` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"cgnonboardingportal"` | no |
| <a name="input_retention_policy_acr"></a> [retention\_policy\_acr](#input\_retention\_policy\_acr) | Container registry retention policy. | <pre>object({<br>    days    = number<br>    enabled = bool<br>  })</pre> | <pre>{<br>  "days": 7,<br>  "enabled": true<br>}</pre> | no |
| <a name="input_sku_container_registry"></a> [sku\_container\_registry](#input\_sku\_container\_registry) | # Azure container registry | `string` | `"Basic"` | no |
| <a name="input_storage_account_lock"></a> [storage\_account\_lock](#input\_storage\_account\_lock) | n/a | <pre>object({<br>    lock_level = string<br>    notes      = string<br>    scope      = string<br>  })</pre> | `null` | no |
| <a name="input_storage_account_versioning"></a> [storage\_account\_versioning](#input\_storage\_account\_versioning) | Enable versioning in the blob storage account. | `bool` | `true` | no |
| <a name="input_storage_account_website_lock"></a> [storage\_account\_website\_lock](#input\_storage\_account\_website\_lock) | n/a | <pre>object({<br>    lock_level = string<br>    notes      = string<br>    scope      = string<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->