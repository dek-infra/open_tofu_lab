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
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  
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
}

variable "servers" {
  description = "A map of server names to their instance types"
  type = map(object({
    instance_type = string
  }))
  default = {
    "web" = { instance_type = "t2.micro" } # ~1 vCPU, 1GB RAM
    "db"  = { instance_type = "t3.small" } # ~2 vCPU, 2GB RAM
  }
}

# 3. Resource Block: Create multiple EC2 instances using for_each
resource "aws_instance" "local_server" {
  for_each = var.servers

  # LocalStack accepts any valid-formatted AMI ID for mocking
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = each.value.instance_type

  tags = {
    Name = "${each.key}-server"
  }
}

# 4. Output Blocks: Display IDs for all created instances
output "instance_ids" {
  description = "The IDs of all provisioned EC2 instances"
  value       = { for k, v in aws_instance.local_server : k => v.id }
}
