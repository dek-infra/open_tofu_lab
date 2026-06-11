provider "gitlab" {
  base_url = var.gitlab_base_url
  # The provider automatically uses the GITLAB_TOKEN environment variable
  insecure = true # Skip TLS verification for internal/self-signed certificates
}

# Call our custom repository module dynamically
module "managed_repos" {
  source   = "./modules/repository"
  for_each = var.repositories

  name         = each.key
  description  = each.value.description
  visibility   = each.value.visibility
  namespace_id = each.value.namespace_id
}