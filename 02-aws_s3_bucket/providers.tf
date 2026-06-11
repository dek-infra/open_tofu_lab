terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Crucial for LocalStack S3 compatibility
  s3_use_path_style = true

  endpoints {
    s3  = "http://172.16.29.44:4566"
    sts = "http://172.16.29.44:4566"
    iam = "http://172.16.29.44:4566"
  }
}