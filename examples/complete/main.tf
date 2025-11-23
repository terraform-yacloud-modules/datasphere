module "datasphere" {
  source = "../../"

  # Provide organization id via variable for the example (set in terraform.tfvars)
  organization_id = "you-organization-id"

  community_name        = "example-datasphere-community"
  community_description = "Сообщество для аналитиков и экспериментов"

  community_labels = {
    environment = "dev"
    team        = "data-platform"
  }

  community_iam_role = "datasphere.communities.developer"
  community_iam_members = [
    "system:allAuthenticatedUsers",
  ]

  project_name        = "example-datasphere-project"
  project_description = "Проект для тестовых вычислений"

  project_labels = {
    environment = "dev"
    owner       = "data-team"
  }

  project_limits = {
    max_units_per_hour      = 100
    max_units_per_execution = 20
    balance                 = 1000
  }

  project_settings = {
    service_account_id   = ""
    subnet_id            = ""
    commit_mode          = "AUTO"
    default_folder_id    = ""
    security_group_ids   = []
    ide                  = "JUPYTER_LAB"
    stale_exec_timeout_mode = "ONE_HOUR"
  }

  project_iam_role = "datasphere.community-projects.developer"
  project_iam_members = [
    "system:allAuthenticatedUsers",
  ]

}
