# Yandex Cloud DataSphere Terraform module

Terraform-модуль для создания ресурсов Yandex Cloud DataSphere: сообщества
(community), основного проекта и произвольного количества дополнительных
проектов в этом сообществе, а также IAM-привязок для них.

## Описание

Модуль создаёт:

- `yandex_datasphere_community` — сообщество DataSphere;
- `yandex_datasphere_project.this` — основной проект, который настраивается
  переменными `project_*`;
- `yandex_datasphere_project.additional` — дополнительные проекты, которые
  описываются картой `additional_projects`;
- `yandex_datasphere_community_iam_binding` — IAM-привязки сообщества
  (`community_iam_bindings`);
- `yandex_datasphere_project_iam_binding` — IAM-привязки основного и
  дополнительных проектов.

### Дополнительные проекты

Переменная `additional_projects` позволяет создать несколько проектов в одном
сообществе. Ключ карты — произвольный идентификатор проекта, он же используется
в выходе `additional_project_ids`. Для каждого проекта можно задать:

| Поле | Описание |
|------|----------|
| `name` | Имя проекта (обязательное) |
| `description` | Описание проекта |
| `labels` | Метки проекта |
| `limits` | Лимиты проекта: `max_units_per_hour`, `max_units_per_execution`, `balance` |
| `settings` | Настройки проекта: `service_account_id`, `subnet_id`, `data_proc_cluster_id`, `security_group_ids`, `default_folder_id`, `stale_exec_timeout_mode` |
| `iam_bindings` | Карта «роль → список участников» для IAM-привязок проекта |

Основной проект, описанный переменными `project_name`, `project_description`,
`project_labels`, `project_limits` и `project_settings`, создаётся всегда, даже
если `additional_projects` не задана.

### Пример использования

```hcl
module "datasphere" {
  source = "terraform-yacloud-modules/datasphere/yandex"

  community_name = "example-community"
  project_name   = "example-project"

  organization_id = var.organization_id

  additional_projects = {
    analytics = {
      name        = "example-project-analytics"
      description = "Дополнительный проект для аналитики"
      labels = {
        purpose = "analytics"
      }
      limits = {
        max_units_per_hour = 5
      }
      settings = {
        service_account_id = yandex_iam_service_account.this.id
        subnet_id          = yandex_vpc_subnet.this.id
      }
      iam_bindings = {
        "datasphere.community-projects.developer" = [
          "serviceAccount:${yandex_iam_service_account.this.id}"
        ]
      }
    }
  }
}
```

### Выходы

| Выход | Описание |
|-------|----------|
| `community_id` | ID сообщества DataSphere |
| `project_id` | ID основного проекта |
| `additional_project_ids` | Карта «ключ проекта → ID» для дополнительных проектов |

## Примеры

Примеры находятся в каталоге
[`examples`](https://github.com/terraform-yacloud-modules/datasphere/tree/main/examples)
и показывают, как использовать модуль, а также служат для проверки изменений
исходного кода. При доработке модуля обновляйте примеры, чтобы поддерживать их
актуальными.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [yandex_datasphere_community.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/datasphere_community) | resource |
| [yandex_datasphere_community_iam_binding.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/datasphere_community_iam_binding) | resource |
| [yandex_datasphere_project.additional](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/datasphere_project) | resource |
| [yandex_datasphere_project.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/datasphere_project) | resource |
| [yandex_datasphere_project_iam_binding.additional](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/datasphere_project_iam_binding) | resource |
| [yandex_datasphere_project_iam_binding.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/datasphere_project_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_additional_projects"></a> [additional\_projects](#input\_additional\_projects) | Additional DataSphere projects created in the same community, keyed by an arbitrary project key. The primary project is configured with the project\_* variables | <pre>map(object({<br/>    name        = string<br/>    description = optional(string)<br/>    labels      = optional(map(string))<br/>    limits = optional(object({<br/>      max_units_per_hour      = optional(number)<br/>      max_units_per_execution = optional(number)<br/>      balance                 = optional(number)<br/>    }))<br/>    settings = optional(object({<br/>      service_account_id      = optional(string)<br/>      subnet_id               = optional(string)<br/>      data_proc_cluster_id    = optional(string)<br/>      security_group_ids      = optional(set(string))<br/>      default_folder_id       = optional(string)<br/>      stale_exec_timeout_mode = optional(string)<br/>    }))<br/>    iam_bindings = optional(map(set(string)), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | ID of the billing account associated with the DataSphere community | `string` | `null` | no |
| <a name="input_community_description"></a> [community\_description](#input\_community\_description) | Description of the DataSphere community | `string` | `null` | no |
| <a name="input_community_iam_bindings"></a> [community\_iam\_bindings](#input\_community\_iam\_bindings) | Map of IAM roles to member lists for the DataSphere community | `map(set(string))` | `{}` | no |
| <a name="input_community_labels"></a> [community\_labels](#input\_community\_labels) | Labels assigned to the DataSphere community | `map(string)` | `null` | no |
| <a name="input_community_name"></a> [community\_name](#input\_community\_name) | Name of the DataSphere community | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | ID of the Yandex Cloud organization where the community is created. If omitted, the provider-level organization\_id is used | `string` | `null` | no |
| <a name="input_project_description"></a> [project\_description](#input\_project\_description) | Description of the DataSphere project | `string` | `null` | no |
| <a name="input_project_iam_bindings"></a> [project\_iam\_bindings](#input\_project\_iam\_bindings) | Map of IAM roles to member lists for the DataSphere project | `map(set(string))` | `{}` | no |
| <a name="input_project_labels"></a> [project\_labels](#input\_project\_labels) | Labels assigned to the DataSphere project | `map(string)` | `null` | no |
| <a name="input_project_limits"></a> [project\_limits](#input\_project\_limits) | Limits configuration of the DataSphere project | <pre>object({<br/>    max_units_per_hour      = optional(number)<br/>    max_units_per_execution = optional(number)<br/>    balance                 = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the DataSphere project | `string` | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | Settings configuration of the DataSphere project | <pre>object({<br/>    service_account_id      = optional(string)<br/>    subnet_id               = optional(string)<br/>    data_proc_cluster_id    = optional(string)<br/>    security_group_ids      = optional(set(string))<br/>    default_folder_id       = optional(string)<br/>    stale_exec_timeout_mode = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_additional_project_ids"></a> [additional\_project\_ids](#output\_additional\_project\_ids) | IDs of the additional DataSphere projects, keyed by project key |
| <a name="output_community_id"></a> [community\_id](#output\_community\_id) | ID of the DataSphere community |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | ID of the DataSphere project |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/datasphere/blob/main/LICENSE).
