# APIM v2 Module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.111.0 |
| <a name="requirement_pkcs12"></a> [pkcs12](#requirement\_pkcs12) | >= 0.2.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_ade_aa_mock_api_v2"></a> [apim\_ade\_aa\_mock\_api\_v2](#module\_apim\_ade\_aa\_mock\_api\_v2) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v8.26.5 |
| <a name="module_apim_backend_api_v2"></a> [apim\_backend\_api\_v2](#module\_apim\_backend\_api\_v2) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v8.26.5 |
| <a name="module_apim_backoffice_api_v2"></a> [apim\_backoffice\_api\_v2](#module\_apim\_backoffice\_api\_v2) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v8.26.5 |
| <a name="module_apim_public_api_v2"></a> [apim\_public\_api\_v2](#module\_apim\_public\_api\_v2) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v8.26.5 |
| <a name="module_apim_spid_login_api_v2"></a> [apim\_spid\_login\_api\_v2](#module\_apim\_spid\_login\_api\_v2) | git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api | v8.26.5 |
| <a name="module_apim_v2"></a> [apim\_v2](#module\_apim\_v2) | ../../modules/apim | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api_operation_policy.spid_acs_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_certificate.jwt_certificate_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_certificate) | resource |
| [azurerm_api_management_custom_domain.api_custom_domain_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_custom_domain) | resource |
| [azurerm_api_management_product.cgn_onbording_portal_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product) | resource |
| [azurerm_key_vault_access_policy.api_management_policy_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_network_security_group.nsg_apim_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_subnet_network_security_group_association.snet_nsg_v2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_container_group.spid_testenv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_group) | data source |
| [azurerm_dns_cname_record.frontend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_cname_record) | data source |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_dns_zone.public_uat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_certificate.apim_proxy_endpoint_cert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.jwt_pkcs12_pem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_linux_web_app.ade_aa_mock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_linux_web_app.portal_backend_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_linux_web_app.spid_login](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_private_dns_a_record.private_dns_a_record_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_a_record) | data source |
| [azurerm_private_dns_zone.api_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_sec](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_spid_testenv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.subnet_apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adb2c_audience"></a> [adb2c\_audience](#input\_adb2c\_audience) | recipients that the JWT is intended for | `string` | n/a | yes |
| <a name="input_adb2c_openid_config_url"></a> [adb2c\_openid\_config\_url](#input\_adb2c\_openid\_config\_url) | Azure AD B2C OpenID Connect metadata document | `string` | n/a | yes |
| <a name="input_apim_notification_sender_email"></a> [apim\_notification\_sender\_email](#input\_apim\_notification\_sender\_email) | n/a | `string` | n/a | yes |
| <a name="input_apim_publisher_email"></a> [apim\_publisher\_email](#input\_apim\_publisher\_email) | n/a | `string` | n/a | yes |
| <a name="input_apim_publisher_name"></a> [apim\_publisher\_name](#input\_apim\_publisher\_name) | n/a | `string` | n/a | yes |
| <a name="input_apim_sku"></a> [apim\_sku](#input\_apim\_sku) | n/a | `string` | `"Developer_1"` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | n/a | `string` | `null` | no |
| <a name="input_dns_zone_prefix_uat"></a> [dns\_zone\_prefix\_uat](#input\_dns\_zone\_prefix\_uat) | n/a | `string` | `null` | no |
| <a name="input_enable_ade_aa_mock"></a> [enable\_ade\_aa\_mock](#input\_enable\_ade\_aa\_mock) | ADE | `bool` | `false` | no |
| <a name="input_enable_custom_dns"></a> [enable\_custom\_dns](#input\_enable\_custom\_dns) | # DNS | `bool` | `false` | no |
| <a name="input_enable_spid_test"></a> [enable\_spid\_test](#input\_enable\_spid\_test) | Create spid test container group. Default false | `bool` | `false` | no |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | n/a | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"cgnonboardingportal"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apim_v2_gateway_url"></a> [apim\_v2\_gateway\_url](#output\_apim\_v2\_gateway\_url) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
