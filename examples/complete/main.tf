provider "yandex" {
  cloud_id        = var.cloud_id
  folder_id       = var.folder_id
  organization_id = var.organization_id
}

data "yandex_client_config" "client" {}

locals {
  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
}

resource "yandex_vpc_network" "this" {
  name = "example-datasphere-network"
}

resource "yandex_vpc_subnet" "this" {
  name           = "example-datasphere-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_security_group" "this" {
  name       = "example-datasphere-security-group"
  network_id = yandex_vpc_network.this.id

  ingress {
    protocol       = "TCP"
    description    = "healthchecks"
    port           = 30080
    v4_cidr_blocks = ["198.18.235.0/24", "198.18.248.0/24"]
  }

  egress {
    protocol       = "ANY"
    description    = "allow all egress"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_iam_service_account" "this" {
  name        = "example-datasphere-service-account"
  description = "Service account used by the DataSphere project"
}

resource "yandex_resourcemanager_folder_iam_member" "this" {
  folder_id = local.folder_id
  member    = "serviceAccount:${yandex_iam_service_account.this.id}"
  role      = "editor"
}

module "datasphere" {
  source = "../../"

  community_name        = "example-datasphere-community-complete"
  community_description = "DataSphere community created by the complete example"
  community_labels = {
    example = "complete"
  }
  organization_id    = var.organization_id
  billing_account_id = var.billing_account_id

  project_name        = "example-datasphere-project-complete"
  project_description = "DataSphere project created by the complete example"
  project_labels = {
    example = "complete"
  }

  project_limits = {
    max_units_per_hour      = 10
    max_units_per_execution = 10
    balance                 = 10
  }

  project_settings = {
    service_account_id      = yandex_iam_service_account.this.id
    subnet_id               = yandex_vpc_subnet.this.id
    security_group_ids      = [yandex_vpc_security_group.this.id]
    default_folder_id       = local.folder_id
    stale_exec_timeout_mode = "ONE_HOUR"
  }

  community_iam_bindings = {
    "datasphere.communities.developer" = ["serviceAccount:${yandex_iam_service_account.this.id}"]
  }

  project_iam_bindings = {
    "datasphere.community-projects.developer" = ["serviceAccount:${yandex_iam_service_account.this.id}"]
  }

  depends_on = [yandex_resourcemanager_folder_iam_member.this]
}
