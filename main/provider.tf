terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52"
    }
  }
}

provider "aws" {
  region     = var.aws_region
}

terraform {
  cloud {
    organization = "safderun"
    workspaces {
      name = "Personal_Aws"
    }
  }
}