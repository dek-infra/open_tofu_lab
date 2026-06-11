variable "name" {
  description = "The name of the repository"
  type        = string
}

variable "description" {
  description = "The description of the repository"
  type        = string
}

variable "visibility" {
  description = "Visibility level (public, private, internal)"
  type        = string
}

variable "namespace_id" {
  description = "The ID of the group/subgroup (Namespace ID in GitLab)"
  type        = number
  default     = null
}