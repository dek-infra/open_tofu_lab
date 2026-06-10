variable "servers" {
  description = "A map of server names to their instance types"
  type = map(object({
    instance_type = string
  }))
  default = {
    "web"       = { instance_type = "t2.micro" } # ~1 vCPU, 1GB RAM
    "db"        = { instance_type = "t3.small" } # ~2 vCPU, 2GB RAM
    "analytics" = { instance_type = "t3.large" } # ~2 vCPU, 8GB RAM (Higher memory)
  }
}