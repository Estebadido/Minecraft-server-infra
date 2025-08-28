terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configuro la regione AWS
provider "aws" {
  region = var.region
  profile = "default"
}