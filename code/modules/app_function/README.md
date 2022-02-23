## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan) | resource |
| [azurerm_app_service_slot_virtual_network_swift_connection.app_service_slot_virtual_network_swift_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot_virtual_network_swift_connection) | resource |
| [azurerm_app_service_virtual_network_swift_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_function_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app) | resource |
| [azurerm_function_app_slot.slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_slot) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights_instrumentation_key"></a> [application\_insights\_instrumentation\_key](#input\_application\_insights\_instrumentation\_key) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Function App Name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | n/a | `list(string)` | `[]` | no |
| <a name="input_allowed_subnets"></a> [allowed\_subnets](#input\_allowed\_subnets) | n/a | `list(string)` | `[]` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | App settings. | `map(any)` | `{}` | no |
| <a name="input_app_settings_slot"></a> [app\_settings\_slot](#input\_app\_settings\_slot) | App settings for the slot function. | `map(any)` | `{}` | no |
| <a name="input_cors"></a> [cors](#input\_cors) | n/a | <pre>object({<br>    allowed_origins = list(string)<br>  })</pre> | `null` | no |
| <a name="input_health_check_maxpingfailures"></a> [health\_check\_maxpingfailures](#input\_health\_check\_maxpingfailures) | n/a | `number` | `10` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | n/a | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | n/a | `string` | `"linux"` | no |
| <a name="input_plan_info"></a> [plan\_info](#input\_plan\_info) | n/a | <pre>object({<br>    kind     = string<br>    sku_tier = string<br>    sku_size = string<br>  })</pre> | <pre>{<br>  "kind": "elastic",<br>  "sku_size": "EP1",<br>  "sku_tier": "ElasticPremium"<br>}</pre> | no |
| <a name="input_pre_warmed_instance_count"></a> [pre\_warmed\_instance\_count](#input\_pre\_warmed\_instance\_count) | n/a | `number` | `1` | no |
| <a name="input_runtime_version"></a> [runtime\_version](#input\_runtime\_version) | n/a | `string` | `"~3"` | no |
| <a name="input_slot_name"></a> [slot\_name](#input\_slot\_name) | Function slot name. If null the slot wouldn't be created. | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | `null` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
