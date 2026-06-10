# 3. Resource Block: Create multiple EC2 instances using for_each
resource "aws_instance" "local_server" {
  for_each = var.servers

  # LocalStack accepts any valid-formatted AMI ID for mocking
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = each.value.instance_type

  tags = {
    # This tag merges with the default_tags from the provider block
    Name = "local-${each.key}-server"
  }
}
