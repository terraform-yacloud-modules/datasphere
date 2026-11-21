output "community_id" {
  description = "ID of the DataSphere community"
  value       = yandex_datasphere_community.this.id
}

output "project_id" {
  description = "ID of the DataSphere project"
  value       = yandex_datasphere_project.this.id
}

output "additional_project_ids" {
  description = "IDs of the additional DataSphere projects, keyed by project key"
  value       = { for key, project in yandex_datasphere_project.additional : key => project.id }
}
