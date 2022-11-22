# cdn_endpoint

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cdn_endpoint.cdn_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delivery_rule_request_scheme_condition"></a> [delivery\_rule\_request\_scheme\_condition](#input\_delivery\_rule\_request\_scheme\_condition) | n/a | <pre>list(object({<br>    name         = string<br>    order        = number<br>    operator     = string<br>    match_values = list(string)<br>    url_redirect_action = object({<br>      redirect_type = string<br>      protocol      = string<br>      hostname      = string<br>      path          = string<br>      fragment      = string<br>      query_string  = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_delivery_rule_url_path_condition_cache_expiration_action"></a> [delivery\_rule\_url\_path\_condition\_cache\_expiration\_action](#input\_delivery\_rule\_url\_path\_condition\_cache\_expiration\_action) | n/a | <pre>list(object({<br>    name         = string<br>    order        = number<br>    operator     = string<br>    match_values = list(string)<br>    behavior     = string<br>    duration     = string<br>  }))</pre> | `[]` | no |
| <a name="input_global_delivery_rule"></a> [global\_delivery\_rule](#input\_global\_delivery\_rule) | n/a | <pre>object({<br>    cache_expiration_action = list(object({<br>      behavior = string<br>      duration = string<br>    }))<br>    cache_key_query_string_action = list(object({<br>      behavior   = string<br>      parameters = string<br>    }))<br>    modify_request_header_action = list(object({<br>      action = string<br>      name   = string<br>      value  = string<br>    }))<br>    modify_response_header_action = list(object({<br>      action = string<br>      name   = string<br>      value  = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_is_http_allowed"></a> [is\_http\_allowed](#input\_is\_http\_allowed) | n/a | `bool` | `false` | no |
| <a name="input_is_https_allowed"></a> [is\_https\_allowed](#input\_is\_https\_allowed) | n/a | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_origin_host_name"></a> [origin\_host\_name](#input\_origin\_host\_name) | TODO: Allow multiple origin | `string` | n/a | yes |
| <a name="input_profile_name"></a> [profile\_name](#input\_profile\_name) | n/a | `string` | n/a | yes |
| <a name="input_querystring_caching_behaviour"></a> [querystring\_caching\_behaviour](#input\_querystring\_caching\_behaviour) | n/a | `string` | `"IgnoreQueryString"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
