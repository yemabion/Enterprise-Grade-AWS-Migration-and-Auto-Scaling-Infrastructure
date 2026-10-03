terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "Enterprise-Grade-AWS-Infrastructure"
      Environment = "Production"
      ManagedBy   = "Terraform"
      Owner       = "CloudEngineering"
    }
  }
}