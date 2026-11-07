provider "yandex" {
  cloud_id        = var.cloud_id
  folder_id       = var.folder_id
  organization_id = var.organization_id
}

module "datasphere" {
  source = "../../"

  community_name = "example-datasphere-community"
  project_name   = "example-datasphere-project"

  organization_id    = var.organization_id
  billing_account_id = var.billing_account_id
}
