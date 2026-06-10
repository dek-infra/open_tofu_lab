# 1. Terraform Block: Tells OpenTofu which provider plugins to download
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2" # Pegging to a version with a known-good signature
    }
  }
}

# 2. Provider Block: Initializes the connection to Docker
provider "docker" {

}

# 3. Resource Block: Downloads the Nginx Docker Image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

# 4. Resource Block: Runs the Docker Container
resource "docker_container" "nginx_server" {
  image = docker_image.nginx.image_id
  name  = "nginx"
  
  ports {
    internal = 80
    external = 8080
  }
}