variable "gitlab_base_url" {
  description = "The base URL of the GitLab instance"
  type        = string
  default     = "https://gitlab.tlnw.magnecomp.com/api/v4/" # Defaults to SaaS
}

variable "repositories" {
  description = "A map of repositories to provision"
  type = map(object({
    description  = string
    visibility   = string
    namespace_id = optional(number)
  }))
}