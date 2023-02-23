terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

terraform {
  cloud {
    organization = "safderun"
    workspaces {
      name = "Personal_Aws"
    }
  }
}