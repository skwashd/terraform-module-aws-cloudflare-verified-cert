terraform {
  required_version = ">= 1.10.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0, < 6.20.1"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 5.3.0, < 6.0.0"
    }
  }
}
