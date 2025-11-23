// Create Datasphere Community
resource "yandex_datasphere_community" "this" {
	name               = var.community_name
	description        = var.community_description
	billing_account_id = var.billing_account_id
	organization_id    = coalesce(var.organization_id, var.billing_account_id)
	labels             = var.community_labels
}

locals {
	effective_project_settings = merge({
		service_account_id       = ""
		subnet_id                = ""
		default_folder_id        = ""
		commit_mode              = "AUTO"
		ide                      = "JUPYTER_LAB"
		stale_exec_timeout_mode  = "ONE_HOUR"
	}, { for k, v in var.project_settings : k => v if !(k == "security_group_ids" && length(coalesce(v, [])) == 0) })

	effective_project_limits = { for k, v in var.project_limits : k => v if !(k == "balance" && var.billing_account_id == null) }
}

// IAM binding for the community
resource "yandex_datasphere_community_iam_binding" "this" {
	community_id = yandex_datasphere_community.this.id
	role         = var.community_iam_role
	members      = var.community_iam_members
}

// Create Datasphere Project inside the community
resource "yandex_datasphere_project" "this" {
	name        = var.project_name
	description = var.project_description

	community_id = yandex_datasphere_community.this.id

	labels = var.project_labels

		limits  = length(keys(local.effective_project_limits)) > 0 ? local.effective_project_limits : null
		settings = length(keys(local.effective_project_settings)) > 0 ? local.effective_project_settings : null
}

// IAM binding for the project
resource "yandex_datasphere_project_iam_binding" "this" {
	project_id = yandex_datasphere_project.this.id
	role       = var.project_iam_role
	members    = var.project_iam_members
}

