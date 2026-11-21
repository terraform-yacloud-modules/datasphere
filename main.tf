locals {
  additional_project_iam_bindings = {
    for binding in flatten([
      for project_key, project in var.additional_projects : [
        for role, members in project.iam_bindings : {
          project_key = project_key
          role        = role
          members     = members
        }
      ]
    ]) : "${binding.project_key}:${binding.role}" => binding
  }
}

resource "yandex_datasphere_community" "this" {
  name               = var.community_name
  description        = var.community_description
  labels             = var.community_labels
  organization_id    = var.organization_id
  billing_account_id = var.billing_account_id
}

resource "yandex_datasphere_project" "this" {
  name         = var.project_name
  description  = var.project_description
  labels       = var.project_labels
  community_id = yandex_datasphere_community.this.id

  limits   = var.project_limits
  settings = var.project_settings
}

resource "yandex_datasphere_project" "additional" {
  for_each = var.additional_projects

  name         = each.value.name
  description  = each.value.description
  labels       = each.value.labels
  community_id = yandex_datasphere_community.this.id

  limits   = each.value.limits
  settings = each.value.settings
}

resource "yandex_datasphere_community_iam_binding" "this" {
  for_each = var.community_iam_bindings

  community_id = yandex_datasphere_community.this.id
  role         = each.key
  members      = each.value
}

resource "yandex_datasphere_project_iam_binding" "this" {
  for_each = var.project_iam_bindings

  project_id = yandex_datasphere_project.this.id
  role       = each.key
  members    = each.value
}

resource "yandex_datasphere_project_iam_binding" "additional" {
  for_each = local.additional_project_iam_bindings

  project_id = yandex_datasphere_project.additional[each.value.project_key].id
  role       = each.value.role
  members    = each.value.members
}
