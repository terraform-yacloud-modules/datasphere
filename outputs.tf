output "community_id" {
  description = "ID of the DataSphere community"
  value       = yandex_datasphere_community.this.id
}

output "project_id" {
  description = "ID of the DataSphere project"
  value       = yandex_datasphere_project.this.id
}
