terraform {
  required_version = ">= 1.6.0" # Compatible with OpenTofu

  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 16.0"
    }
  }
}