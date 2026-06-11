resource "gitlab_project" "this" {
  name             = var.name
  description      = var.description
  visibility_level = var.visibility
  namespace_id     = var.namespace_id

  # Enforce linear history (Git Flow best practice)
  merge_method           = "ff" 
  initialize_with_readme = true # Creates the default branch automatically
}

# Protect the main branch
resource "gitlab_branch_protection" "main" {
  project            = gitlab_project.this.id
  branch             = "main"
  push_access_level  = "no one"      # Nobody can push directly to main
  merge_access_level = "maintainer"  # Only maintainers can merge Pull/Merge Requests
  allow_force_push   = true
}