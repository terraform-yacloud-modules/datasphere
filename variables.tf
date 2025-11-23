// Community variables
variable "community_name" {
	description = "Name of the Datasphere community"
	type        = string
}

variable "community_description" {
	description = "Description for the Datasphere community"
	type        = string
	default     = ""
}

variable "billing_account_id" {
	description = "Billing account (or organization) id to attach to the community"
	type        = string
	default     = null
}

variable "organization_id" {
	description = "Organization id where the community will be created"
	type        = string
	default     = null
	validation {
		condition     = var.organization_id != null || var.billing_account_id != null
		error_message = "Either 'organization_id' or 'billing_account_id' must be provided."
	}
}

variable "community_labels" {
	description = "Labels for the community"
	type        = map(string)
	default     = {}
}

variable "community_iam_role" {
	description = "IAM role to bind on the community"
	type        = string
	default     = "datasphere.communities.developer"
}

variable "community_iam_members" {
	description = "List of members for the community IAM binding"
	type        = list(string)
	default     = ["system:allAuthenticatedUsers"]
}

// Project variables
variable "project_name" {
	description = "Name of the Datasphere project"
	type        = string
}

variable "project_description" {
	description = "Description for the Datasphere project"
	type        = string
	default     = ""
}

variable "project_labels" {
	description = "Labels for the project"
	type        = map(string)
	default     = {}
}

variable "project_limits" {
	description = "Map with numeric limits for the project (max_units_per_hour, max_units_per_execution, balance)"
	type        = map(number)
	default     = {}
}

variable "project_settings" {
	description = "Nested settings for the project (service_account_id, subnet_id, lists, etc.). Use an empty map to skip."
	type        = any
	default     = {}
}

variable "project_iam_role" {
	description = "IAM role to bind on the project"
	type        = string
	default     = "datasphere.community-projects.developer"
}

variable "project_iam_members" {
	description = "List of members for the project IAM binding"
	type        = list(string)
	default     = ["system:allAuthenticatedUsers"]
}

