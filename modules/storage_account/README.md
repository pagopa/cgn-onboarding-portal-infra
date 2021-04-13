
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| [azurerm_advanced_threat_protection.advanced_threat_protection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection) | resource |
| [azurerm_management_lock.management_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_template_deployment.versioning](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/template_deployment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | n/a | `string` | n/a | yes |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | n/a | `string` | n/a | yes |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_lock_name"></a> [lock\_name](#input\_lock\_name) | The name of the storage account lock resource | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the storage account resource | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_versioning_name"></a> [versioning\_name](#input\_versioning\_name) | The name of the storage account versioning resource | `string` | n/a | yes |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | n/a | `string` | `"StorageV2"` | no |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | CORS rules for storage account. | <pre>list(object({<br>    allowed_origins    = list(string)<br>    allowed_methods    = list(string)<br>    allowed_headers    = list(string)<br>    exposed_headers    = list(string)<br>    max_age_in_seconds = number<br>  }))</pre> | `[]` | no |
| <a name="input_custom_404_path"></a> [custom\_404\_path](#input\_custom\_404\_path) | path from your repo root to your custom 404 page | `string` | `"404.html"` | no |
| <a name="input_enable_static_website"></a> [enable\_static\_website](#input\_enable\_static\_website) | Controls if static website to be enabled on the storage account. Possible values are `true` or `false` | `bool` | `false` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Enable versioning in the blob storage account. | `bool` | `true` | no |
| <a name="input_index_path"></a> [index\_path](#input\_index\_path) | path from your repo root to index.html | `string` | `"index.html"` | no |
| <a name="input_lock"></a> [lock](#input\_lock) | Lock the storage account | `bool` | `false` | no |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | Specifies the scope at which the Management Lock should be created. | `string` | `"CanNotDelete"` | no |
| <a name="input_lock_notes"></a> [lock\_notes](#input\_lock\_notes) | Specifies some notes about the lock. Maximum of 512 characters | `string` | `null` | no |
| <a name="input_lock_scope"></a> [lock\_scope](#input\_lock\_scope) | Specifies the scope at which the Management Lock should be created. Usually this is the resource id. | `string` | `null` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | n/a | <pre>object({<br>    default_action             = string # Valid option Deny Allow<br>    bypass                     = set(string)<br>    ip_rules                   = list(string)<br>    virtual_network_subnet_ids = list(string)<br>  })</pre> | `null` | no |
| <a name="input_soft_delete_retention"></a> [soft\_delete\_retention](#input\_soft\_delete\_retention) | Number of retention days for soft delete. If set to null it will disable soft delete all together. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | n/a |
| <a name="output_primary_blob_connection_string"></a> [primary\_blob\_connection\_string](#output\_primary\_blob\_connection\_string) | n/a |
| <a name="output_primary_blob_host"></a> [primary\_blob\_host](#output\_primary\_blob\_host) | n/a |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | n/a |
| <a name="output_primary_web_host"></a> [primary\_web\_host](#output\_primary\_web\_host) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
