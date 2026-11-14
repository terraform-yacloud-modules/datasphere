variable "community_name" {
  description = "Name of the DataSphere community"
  type        = string
}

variable "community_description" {
  description = "Description of the DataSphere community"
  type        = string
  default     = null
}

variable "community_labels" {
  description = "Labels assigned to the DataSphere community"
  type        = map(string)
  default     = null
}

variable "organization_id" {
  description = "ID of the Yandex Cloud organization where the community is created. If omitted, the provider-level organization_id is used"
  type        = string
  default     = null
}

variable "billing_account_id" {
  description = "ID of the billing account associated with the DataSphere community"
  type        = string
  default     = null
}

variable "project_name" {
  description = "Name of the DataSphere project"
  type        = string
}

variable "project_description" {
  description = "Description of the DataSphere project"
  type        = string
  default     = null
}

variable "project_labels" {
  description = "Labels assigned to the DataSphere project"
  type        = map(string)
  default     = null
}

variable "project_limits" {
  description = "Limits configuration of the DataSphere project"
  type = object({
    max_units_per_hour      = optional(number)
    max_units_per_execution = optional(number)
    balance                 = optional(number)
  })
  default = null
}

variable "project_settings" {
  description = "Settings configuration of the DataSphere project"
  type = object({
    service_account_id      = optional(string)
    subnet_id               = optional(string)
    data_proc_cluster_id    = optional(string)
    security_group_ids      = optional(set(string))
    default_folder_id       = optional(string)
    stale_exec_timeout_mode = optional(string)
  })
  default = null
}

variable "community_iam_bindings" {
  description = "Map of IAM roles to member lists for the DataSphere community"
  type        = map(set(string))
  default     = {}
}

variable "project_iam_bindings" {
  description = "Map of IAM roles to member lists for the DataSphere project"
  type        = map(set(string))
  default     = {}
}
