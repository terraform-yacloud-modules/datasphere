variable "organization_id" {
	description = "Organization id where the community will be created (example)"
	type        = string
	default     = "bpf08lnmpl52bp5hoflv"
}

variable "example_override" {
	description = "Placeholder variable for future example overrides"
	type        = map(any)
	default     = {}
}
