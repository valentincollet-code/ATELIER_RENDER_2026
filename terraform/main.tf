terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = ">= 1.7.0"
    }
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

variable "github_actor" {
  description = "GitHub username"
  type        = string
}

resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"
  
  env_vars = {
    ENV = {
      value = "production"
    }
    DATABASE_URL = {
      value = "postgresql://valentin_database_user:1bAmOAhOXttGAFOvJZMI85RlfnWHmWDL@dpg-d8q4tru7r5hc73el89fg-a.frankfurt-postgres.render.com/valentin_database"
    }
  }

  runtime_source = {
    image = {
      image_url = var.image_url
      tag       = var.image_tag
    }
  }
}

resource "render_web_service" "adminer" {
  name        = "adminer-v3-${var.github_actor}"
  plan        = "free"
  region      = "frankfurt"

  runtime_source = {
    image = {
      image_url = "docker.io/library/adminer"
      tag       = "latest"
    }
  }
}
