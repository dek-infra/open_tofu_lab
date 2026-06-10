# 4. Output Blocks: Display IDs for all created instances
output "instance_ids" {
  description = "The IDs of all provisioned EC2 instances"
  value       = { for k, v in aws_instance.local_server : k => v.id }
}