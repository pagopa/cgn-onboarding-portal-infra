## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.52.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.52.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim"></a> [apim](#module\_apim) | ./modules/apim |  |
| <a name="module_apim_backend_api"></a> [apim\_backend\_api](#module\_apim\_backend\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api |  |
| <a name="module_apim_backoffice_api"></a> [apim\_backoffice\_api](#module\_apim\_backoffice\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api |  |
| <a name="module_cdn_portal_frontend"></a> [cdn\_portal\_frontend](#module\_cdn\_portal\_frontend) | ./modules/cdn_endpoint |  |
| <a name="module_cdn_portal_storage"></a> [cdn\_portal\_storage](#module\_cdn\_portal\_storage) | ./modules/cdn_endpoint |  |
| <a name="module_portal_backend_1"></a> [portal\_backend\_1](#module\_portal\_backend\_1) | ./modules/app_service |  |
| <a name="module_redis_cache"></a> [redis\_cache](#module\_redis\_cache) | git::https://github.com/pagopa/azurerm.git//redis_cache |  |
| <a name="module_spid_login"></a> [spid\_login](#module\_spid\_login) | ./modules/app_service |  |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ./modules/storage_account |  |
| <a name="module_storage_account_website"></a> [storage\_account\_website](#module\_storage\_account\_website) | ./modules/storage_account |  |
| <a name="module_subnet_api"></a> [subnet\_api](#module\_subnet\_api) | ./modules/subnet |  |
| <a name="module_subnet_db"></a> [subnet\_db](#module\_subnet\_db) | ./modules/subnet |  |
| <a name="module_subnet_public"></a> [subnet\_public](#module\_subnet\_public) | ./modules/subnet |  |
| <a name="module_subnet_spid_login"></a> [subnet\_spid\_login](#module\_subnet\_spid\_login) | ./modules/subnet |  |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_custom_domain.api_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_custom_domain) | resource |
| [azurerm_application_gateway.api_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_cdn_profile.cdn_profile_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_profile) | resource |
| [azurerm_container_group.sonarqube](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |
| [azurerm_container_group.spid_testenv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_dns_a_record.api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_cname_record.frontend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_certificate.apim_proxy_endpoint_cert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_network_security_group.db_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_postgresql_database.postgresql_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_database) | resource |
| [azurerm_postgresql_server.postgresql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_postgresql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.api_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_dns_zone_postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.api_private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.postgresql_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_public_ip.apigateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_sec](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_sonarqube](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_spid_testenv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.sonarqube_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account.spid_testenv_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.profile_images](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.user_documents](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_share.caddy_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_share.sonarqube_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_share.spid_testenv_caddy_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_share.spid_testenv_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_subnet.subnet_apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [local_file.spid_testenv_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.cdn_custom_domain](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_config_spid_testenv](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_key_vault_group_object_id"></a> [ad\_key\_vault\_group\_object\_id](#input\_ad\_key\_vault\_group\_object\_id) | Active directory object id group that can access key vault. | `string` | n/a | yes |
| <a name="input_apim_name"></a> [apim\_name](#input\_apim\_name) | n/a | `string` | `null` | no |
| <a name="input_apim_notification_sender_email"></a> [apim\_notification\_sender\_email](#input\_apim\_notification\_sender\_email) | n/a | `string` | n/a | yes |
| <a name="input_apim_private_domain"></a> [apim\_private\_domain](#input\_apim\_private\_domain) | n/a | `string` | `"api.cgnonboardingportal.pagopa.it"` | no |
| <a name="input_apim_publisher_email"></a> [apim\_publisher\_email](#input\_apim\_publisher\_email) | n/a | `string` | n/a | yes |
| <a name="input_apim_publisher_name"></a> [apim\_publisher\_name](#input\_apim\_publisher\_name) | n/a | `string` | n/a | yes |
| <a name="input_apim_sku"></a> [apim\_sku](#input\_apim\_sku) | n/a | `string` | `"Developer_1"` | no |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | App Gateway | `number` | `1` | no |
| <a name="input_cidr_subnet_api"></a> [cidr\_subnet\_api](#input\_cidr\_subnet\_api) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_db"></a> [cidr\_subnet\_db](#input\_cidr\_subnet\_db) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_public"></a> [cidr\_subnet\_public](#input\_cidr\_subnet\_public) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_spid_login"></a> [cidr\_subnet\_spid\_login](#input\_cidr\_subnet\_spid\_login) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_vnet"></a> [cidr\_vnet](#input\_cidr\_vnet) | Network | `list(string)` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the database. | `string` | n/a | yes |
| <a name="input_db_administrator_login"></a> [db\_administrator\_login](#input\_db\_administrator\_login) | The Administrator Login for the PostgreSQL Server. | `string` | n/a | yes |
| <a name="input_db_administrator_login_password"></a> [db\_administrator\_login\_password](#input\_db\_administrator\_login\_password) | The Password associated with the administrator\_login. | `string` | n/a | yes |
| <a name="input_db_auto_grow_enabled"></a> [db\_auto\_grow\_enabled](#input\_db\_auto\_grow\_enabled) | Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. | `bool` | `true` | no |
| <a name="input_db_backup_retention_days"></a> [db\_backup\_retention\_days](#input\_db\_backup\_retention\_days) | Backup retention days for the server | `number` | `null` | no |
| <a name="input_db_charset"></a> [db\_charset](#input\_db\_charset) | Specifies the Charset for the PostgreSQL Database | `string` | `"UTF8"` | no |
| <a name="input_db_collation"></a> [db\_collation](#input\_db\_collation) | Specifies the Collation for the PostgreSQL Database. | `string` | `"Italian_Italy.1252"` | no |
| <a name="input_db_create_mode"></a> [db\_create\_mode](#input\_db\_create\_mode) | The creation mode. Can be used to restore or replicate existing servers. | `string` | `"Default"` | no |
| <a name="input_db_public_network_access_enabled"></a> [db\_public\_network\_access\_enabled](#input\_db\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this server. | `bool` | `false` | no |
| <a name="input_db_sku_name"></a> [db\_sku\_name](#input\_db\_sku\_name) | Specifies the SKU Name for this PostgreSQL Server. | `string` | n/a | yes |
| <a name="input_db_ssl_enforcement_enabled"></a> [db\_ssl\_enforcement\_enabled](#input\_db\_ssl\_enforcement\_enabled) | Specifies if SSL should be enforced on connections. | `bool` | `true` | no |
| <a name="input_db_ssl_minimal_tls_version_enforced"></a> [db\_ssl\_minimal\_tls\_version\_enforced](#input\_db\_ssl\_minimal\_tls\_version\_enforced) | The mimimun TLS version to support on the sever. | `string` | `"TLS1_2"` | no |
| <a name="input_db_storage_mb"></a> [db\_storage\_mb](#input\_db\_storage\_mb) | Max storage allowed for a server. | `number` | `5120` | no |
| <a name="input_db_version"></a> [db\_version](#input\_db\_version) | Specifies the version of PostgreSQL to use. | `string` | n/a | yes |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | n/a | `string` | `null` | no |
| <a name="input_enable_sonarqube"></a> [enable\_sonarqube](#input\_enable\_sonarqube) | Enable sonarqube resources | `bool` | `false` | no |
| <a name="input_enable_spid_testenv"></a> [enable\_spid\_testenv](#input\_enable\_spid\_testenv) | Enable SPID TEST ENV resources | `bool` | `false` | no |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | # DNS | `string` | `null` | no |
| <a name="input_law_daily_quota_gb"></a> [law\_daily\_quota\_gb](#input\_law\_daily\_quota\_gb) | The workspace daily quota for ingestion in GB. | `number` | `-1` | no |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | The workspace data retention in days | `number` | `30` | no |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Sku of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"cgnonboardingportal"` | no |
| <a name="input_redis_cache_family"></a> [redis\_cache\_family](#input\_redis\_cache\_family) | The SKU family/pricing group to use. | `string` | n/a | yes |
| <a name="input_redis_cache_sku_name"></a> [redis\_cache\_sku\_name](#input\_redis\_cache\_sku\_name) | The SKU of Redis to use. | `string` | n/a | yes |
| <a name="input_retention_policy_acr"></a> [retention\_policy\_acr](#input\_retention\_policy\_acr) | Container registry retention policy. | <pre>object({<br>    days    = number<br>    enabled = bool<br>  })</pre> | <pre>{<br>  "days": 7,<br>  "enabled": true<br>}</pre> | no |
| <a name="input_sku_container_registry"></a> [sku\_container\_registry](#input\_sku\_container\_registry) | # Azure container registry | `string` | `"Basic"` | no |
| <a name="input_storage_account_lock"></a> [storage\_account\_lock](#input\_storage\_account\_lock) | n/a | <pre>object({<br>    lock_level = string<br>    notes      = string<br>    scope      = string<br>  })</pre> | `null` | no |
| <a name="input_storage_account_versioning"></a> [storage\_account\_versioning](#input\_storage\_account\_versioning) | Enable versioning in the blob storage account. | `bool` | `true` | no |
| <a name="input_storage_account_website_lock"></a> [storage\_account\_website\_lock](#input\_storage\_account\_website\_lock) | n/a | <pre>object({<br>    lock_level = string<br>    notes      = string<br>    scope      = string<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | container registry |
| <a name="output_ai_app_id"></a> [ai\_app\_id](#output\_ai\_app\_id) | n/a |
| <a name="output_ai_instrumentation_key"></a> [ai\_instrumentation\_key](#output\_ai\_instrumentation\_key) | n/a |
| <a name="output_api_gateway_public_id"></a> [api\_gateway\_public\_id](#output\_api\_gateway\_public\_id) | external |
| <a name="output_apim_gateway_url"></a> [apim\_gateway\_url](#output\_apim\_gateway\_url) | n/a |
| <a name="output_db_administrator_login"></a> [db\_administrator\_login](#output\_db\_administrator\_login) | database postgres |
| <a name="output_db_fqdn"></a> [db\_fqdn](#output\_db\_fqdn) | n/a |
| <a name="output_law_workpace_id"></a> [law\_workpace\_id](#output\_law\_workpace\_id) | monitor |
| <a name="output_web_app_1_default_host_name"></a> [web\_app\_1\_default\_host\_name](#output\_web\_app\_1\_default\_host\_name) | web app service |
