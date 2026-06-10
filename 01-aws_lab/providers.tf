# 1. Terraform Block: Tells OpenTofu to download the AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 2. Provider Block: Configured to talk to LocalStack instead of real AWS
provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"

  # Bypass checks since we aren't talking to real AWS
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Point AWS services to the LocalStack container port
  endpoints {
    ec2 = "http://localhost:4566"
    sts = "http://localhost:4566"
    iam = "http://localhost:4566"
  }

  # Best Practice: Use default tags to consistently tag all supported resources
  default_tags {
    tags = {
      Environment = "Local-Dev"
      ManagedBy   = "OpenTofu"
    }
  }
}