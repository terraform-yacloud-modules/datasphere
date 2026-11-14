# Yandex Cloud DataSphere Terraform module

Terraform module which creates Yandex Cloud DataSphere resources: a community,
a project and optional IAM bindings for them.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/datasphere/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_datasphere_community.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/datasphere_community) | resource |
| [yandex_datasphere_community_iam_binding.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/datasphere_community_iam_binding) | resource |
| [yandex_datasphere_project.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/datasphere_project) | resource |
| [yandex_datasphere_project_iam_binding.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/datasphere_project_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | ID of the billing account associated with the DataSphere community | `string` | `null` | no |
| <a name="input_community_description"></a> [community\_description](#input\_community\_description) | Description of the DataSphere community | `string` | `null` | no |
| <a name="input_community_iam_bindings"></a> [community\_iam\_bindings](#input\_community\_iam\_bindings) | Map of IAM roles to member lists for the DataSphere community | `map(set(string))` | `{}` | no |
| <a name="input_community_labels"></a> [community\_labels](#input\_community\_labels) | Labels assigned to the DataSphere community | `map(string)` | `null` | no |
| <a name="input_community_name"></a> [community\_name](#input\_community\_name) | Name of the DataSphere community | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | ID of the Yandex Cloud organization where the community is created. If omitted, the provider-level organization_id is used | `string` | `null` | no |
| <a name="input_project_description"></a> [project\_description](#input\_project\_description) | Description of the DataSphere project | `string` | `null` | no |
| <a name="input_project_iam_bindings"></a> [project\_iam\_bindings](#input\_project\_iam\_bindings) | Map of IAM roles to member lists for the DataSphere project | `map(set(string))` | `{}` | no |
| <a name="input_project_labels"></a> [project\_labels](#input\_project\_labels) | Labels assigned to the DataSphere project | `map(string)` | `null` | no |
| <a name="input_project_limits"></a> [project\_limits](#input\_project\_limits) | Limits configuration of the DataSphere project | <pre>object({<br>    max_units_per_hour      = optional(number)<br>    max_units_per_execution = optional(number)<br>    balance                 = optional(number)<br>  })</pre> | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the DataSphere project | `string` | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | Settings configuration of the DataSphere project | <pre>object({<br>    service_account_id      = optional(string)<br>    subnet_id               = optional(string)<br>    data_proc_cluster_id    = optional(string)<br>    security_group_ids      = optional(set(string))<br>    default_folder_id       = optional(string)<br>    stale_exec_timeout_mode = optional(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_community_id"></a> [community\_id](#output\_community\_id) | ID of the DataSphere community |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | ID of the DataSphere project |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/datasphere/blob/main/LICENSE).
