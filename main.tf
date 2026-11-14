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
