## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.56.0 |
| <a name="requirement_pkcs12"></a> [pkcs12](#requirement\_pkcs12) | 0.0.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | = 2.56.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_pkcs12"></a> [pkcs12](#provider\_pkcs12) | 0.0.6 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ade_aa_mock"></a> [ade\_aa\_mock](#module\_ade\_aa\_mock) | ./modules/app_service |  |
| <a name="module_apim"></a> [apim](#module\_apim) | ./modules/apim |  |
| <a name="module_apim_ade_aa_mock_api"></a> [apim\_ade\_aa\_mock\_api](#module\_apim\_ade\_aa\_mock\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2 |  |
| <a name="module_apim_backend_api"></a> [apim\_backend\_api](#module\_apim\_backend\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2 |  |
| <a name="module_apim_backoffice_api"></a> [apim\_backoffice\_api](#module\_apim\_backoffice\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2 |  |
| <a name="module_apim_public_api"></a> [apim\_public\_api](#module\_apim\_public\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2 |  |
| <a name="module_apim_spid_login_api"></a> [apim\_spid\_login\_api](#module\_apim\_spid\_login\_api) | git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2 |  |
| <a name="module_cdn_portal_frontend"></a> [cdn\_portal\_frontend](#module\_cdn\_portal\_frontend) | ./modules/cdn_endpoint |  |
| <a name="module_cdn_portal_storage"></a> [cdn\_portal\_storage](#module\_cdn\_portal\_storage) | ./modules/cdn_endpoint |  |
| <a name="module_operator_search"></a> [operator\_search](#module\_operator\_search) | ./modules/app_function |  |
| <a name="module_portal_backend_1"></a> [portal\_backend\_1](#module\_portal\_backend\_1) | ./modules/app_service |  |
| <a name="module_redis_cache"></a> [redis\_cache](#module\_redis\_cache) | git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v1.0.2 |  |
| <a name="module_spid_login"></a> [spid\_login](#module\_spid\_login) | ./modules/app_service |  |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ./modules/storage_account |  |
| <a name="module_storage_account_website"></a> [storage\_account\_website](#module\_storage\_account\_website) | ./modules/storage_account |  |
| <a name="module_subnet_ade_aa_mock"></a> [subnet\_ade\_aa\_mock](#module\_subnet\_ade\_aa\_mock) | ./modules/subnet |  |
| <a name="module_subnet_api"></a> [subnet\_api](#module\_subnet\_api) | ./modules/subnet |  |
| <a name="module_subnet_db"></a> [subnet\_db](#module\_subnet\_db) | ./modules/subnet |  |
| <a name="module_subnet_function"></a> [subnet\_function](#module\_subnet\_function) | ./modules/subnet |  |
| <a name="module_subnet_public"></a> [subnet\_public](#module\_subnet\_public) | ./modules/subnet |  |
| <a name="module_subnet_spid_login"></a> [subnet\_spid\_login](#module\_subnet\_spid\_login) | ./modules/subnet |  |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_certificate.jwt_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/api_management_certificate) | resource |
| [azurerm_api_management_custom_domain.api_custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/api_management_custom_domain) | resource |
| [azurerm_api_management_product.cgn_onbording_portal](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/api_management_product) | resource |
| [azurerm_application_gateway.api_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/application_gateway) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/application_insights) | resource |
| [azurerm_cdn_profile.cdn_profile_common](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/cdn_profile) | resource |
| [azurerm_container_group.sonarqube](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/container_group) | resource |
| [azurerm_container_group.spid_testenv](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/container_group) | resource |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/container_registry) | resource |
| [azurerm_dns_a_record.api](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/dns_a_record) | resource |
| [azurerm_dns_cname_record.frontend](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/dns_zone) | resource |
| [azurerm_dns_zone.public_uat](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/dns_zone) | resource |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.api_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.app_gateway_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.cert_renew_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.terraform_cloud_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_certificate.apim_proxy_endpoint_cert](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/key_vault_certificate) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_network_security_group.db_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_security_group) | resource |
| [azurerm_postgresql_database.postgresql_database](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/postgresql_database) | resource |
| [azurerm_postgresql_server.postgresql_server](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/postgresql_server) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.private_dns_a_record_postgresql](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.api_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.private_dns_zone_postgres](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.api_private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.postgresql_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/private_endpoint) | resource |
| [azurerm_public_ip.apigateway_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_public](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_sec](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_sonarqube](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_spid_testenv](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.ade_aa_mock](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/storage_account) | resource |
| [azurerm_storage_account.sonarqube_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/storage_account) | resource |
| [azurerm_storage_account.spid_testenv_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.ade_aa_config](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.profile_images](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.user_documents](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/storage_container) | resource |
| [azurerm_storage_share.caddy_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/storage_share) | resource |
| [azurerm_storage_share.sonarqube_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/storage_share) | resource |
| [azurerm_storage_share.spid_testenv_caddy_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/storage_share) | resource |
| [azurerm_storage_share.spid_testenv_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/storage_share) | resource |
| [azurerm_subnet.subnet_apim](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/subnet) | resource |
| [azurerm_user_assigned_identity.main](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/virtual_network) | resource |
| [local_file.spid_testenv_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.cdn_custom_domain](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.upload_config_spid_testenv](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [pkcs12_from_pem.jwt_pkcs12](https://registry.terraform.io/providers/chilicat/pkcs12/0.0.6/docs/resources/from_pem) | resource |
| [tls_private_key.jwt](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.spid](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.jwt_self](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [tls_self_signed_cert.spid_self](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_secret.agid_spid_private_key](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.agid_spid_cert](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.app_gw_cert](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.backend_client_id](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.backend_client_secret](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_key_vault_group_object_id"></a> [ad\_key\_vault\_group\_object\_id](#input\_ad\_key\_vault\_group\_object\_id) | Active directory object id group that can access key vault. | `string` | n/a | yes |
| <a name="input_adb2c_audience"></a> [adb2c\_audience](#input\_adb2c\_audience) | recipients that the JWT is intended for | `string` | n/a | yes |
| <a name="input_adb2c_openid_config_url"></a> [adb2c\_openid\_config\_url](#input\_adb2c\_openid\_config\_url) | Azure AD B2C OpenID Connect metadata document | `string` | n/a | yes |
| <a name="input_agid_spid_private_key"></a> [agid\_spid\_key\_name](#input\_agid\_spid\_key\_name) | Secret name with agid spid key file content | `string` | `null` | no |
| <a name="input_agid_spid_public_cert"></a> [agid\_spid\_pem\_name](#input\_agid\_spid\_pem\_name) | Secret name with agid spid pem file content | `string` | `null` | no |
| <a name="input_apim_name"></a> [apim\_name](#input\_apim\_name) | n/a | `string` | `null` | no |
| <a name="input_apim_notification_sender_email"></a> [apim\_notification\_sender\_email](#input\_apim\_notification\_sender\_email) | n/a | `string` | n/a | yes |
| <a name="input_apim_private_domain"></a> [apim\_private\_domain](#input\_apim\_private\_domain) | n/a | `string` | `"api.cgnonboardingportal.pagopa.it"` | no |
| <a name="input_apim_publisher_email"></a> [apim\_publisher\_email](#input\_apim\_publisher\_email) | n/a | `string` | n/a | yes |
| <a name="input_apim_publisher_name"></a> [apim\_publisher\_name](#input\_apim\_publisher\_name) | n/a | `string` | n/a | yes |
| <a name="input_apim_sku"></a> [apim\_sku](#input\_apim\_sku) | n/a | `string` | `"Developer_1"` | no |
| <a name="input_app_gateway_certificate_name"></a> [app\_gateway\_certificate\_name](#input\_app\_gateway\_certificate\_name) | Application gateway certificate name on Key Vault | `string` | `null` | no |
| <a name="input_app_gateway_host_name"></a> [app\_gateway\_host\_name](#input\_app\_gateway\_host\_name) | Application gateway host name | `string` | n/a | yes |
| <a name="input_app_gateway_max_capacity"></a> [app\_gateway\_max\_capacity](#input\_app\_gateway\_max\_capacity) | n/a | `number` | `2` | no |
| <a name="input_app_gateway_min_capacity"></a> [app\_gateway\_min\_capacity](#input\_app\_gateway\_min\_capacity) | App Gateway | `number` | `1` | no |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | AZURE\_CLIENT\_SECRET | `any` | `null` | no |
| <a name="input_cert_renew_app_id"></a> [cert\_renew\_app\_id](#input\_cert\_renew\_app\_id) | Application id of the azure devops app responsible to create and renew tsl certificates. | `string` | `null` | no |
| <a name="input_cert_renew_app_object_id"></a> [cert\_renew\_app\_object\_id](#input\_cert\_renew\_app\_object\_id) | Object id of the azure devops app responsible to create and renew tsl certificates. | `string` | `null` | no |
| <a name="input_cidr_subnet_ade_aa_mock"></a> [cidr\_subnet\_ade\_aa\_mock](#input\_cidr\_subnet\_ade\_aa\_mock) | n/a | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_api"></a> [cidr\_subnet\_api](#input\_cidr\_subnet\_api) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_apim"></a> [cidr\_subnet\_apim](#input\_cidr\_subnet\_apim) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_db"></a> [cidr\_subnet\_db](#input\_cidr\_subnet\_db) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_function"></a> [cidr\_subnet\_function](#input\_cidr\_subnet\_function) | n/a | `list(string)` | n/a | yes |
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
| <a name="input_dns_zone_prefix_uat"></a> [dns\_zone\_prefix\_uat](#input\_dns\_zone\_prefix\_uat) | TODO these \_uat are a temponary resources | `string` | `null` | no |
| <a name="input_email_department_email"></a> [email\_department\_email](#input\_email\_department\_email) | Receipent email address of the CGN Onboarding Department | `string` | n/a | yes |
| <a name="input_email_host"></a> [email\_host](#input\_email\_host) | email server hostname | `string` | `"fast.smtpok.com"` | no |
| <a name="input_email_password"></a> [email\_password](#input\_email\_password) | n/a | `string` | n/a | yes |
| <a name="input_email_port"></a> [email\_port](#input\_email\_port) | email server port | `number` | `80` | no |
| <a name="input_email_username"></a> [email\_username](#input\_email\_username) | n/a | `string` | n/a | yes |
| <a name="input_enable_ade_aa_mock"></a> [enable\_ade\_aa\_mock](#input\_enable\_ade\_aa\_mock) | ADE | `bool` | `false` | no |
| <a name="input_enable_custom_dns"></a> [enable\_custom\_dns](#input\_enable\_custom\_dns) | # DNS | `bool` | `false` | no |
| <a name="input_enable_sonarqube"></a> [enable\_sonarqube](#input\_enable\_sonarqube) | Enable sonarqube resources | `bool` | `false` | no |
| <a name="input_enable_spid_test"></a> [enable\_spid\_test](#input\_enable\_spid\_test) | Create spid test container group. Default false | `bool` | `false` | no |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | n/a | `string` | `null` | no |
| <a name="input_io_apim_name"></a> [io\_apim\_name](#input\_io\_apim\_name) | n/a | `string` | `null` | no |
| <a name="input_io_apim_productid"></a> [io\_apim\_productid](#input\_io\_apim\_productid) | n/a | `string` | `null` | no |
| <a name="input_io_apim_resourcegroup"></a> [io\_apim\_resourcegroup](#input\_io\_apim\_resourcegroup) | API TOKEN | `string` | `null` | no |
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
