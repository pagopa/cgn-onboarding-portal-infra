
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | 0.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_variable.dev_apim_notification_sender_email](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_apim_publisher_email](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_apim_publisher_name](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_cidr_subnet_api](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_cidr_subnet_apim](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_cidr_subnet_db](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_cidr_subnet_public](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_cidr_vnet](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_database_name](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_db_sku_name](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_db_version](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_dns_zone_prefix](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_enable_sonarqube](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_env_short](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_external_domain](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_parent_resource_group_name](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.dev_tags](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.prod_env_short](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.prod_tags](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_apim_notification_sender_email](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_apim_publisher_email](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_apim_publisher_name](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_cidr_subnet_api](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_cidr_subnet_apim](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_cidr_subnet_db](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_cidr_subnet_public](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_cidr_vnet](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_database_name](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_db_sku_name](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_db_version](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_enable_sonarqube](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_env_short](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_variable.uat_tags](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/resources/variable) | resource |
| [tfe_workspace.dev](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/data-sources/workspace) | data source |
| [tfe_workspace.prod](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/data-sources/workspace) | data source |
| [tfe_workspace.uat](https://registry.terraform.io/providers/hashicorp/tfe/0.24.0/docs/data-sources/workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tfe_organization_name"></a> [tfe\_organization\_name](#input\_tfe\_organization\_name) | The name of the Terraform Cloud Organization | `string` | `"bitrock-pagopa"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
