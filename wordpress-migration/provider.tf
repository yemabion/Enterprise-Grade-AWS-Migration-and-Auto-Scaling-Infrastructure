provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "Enterprise-Grade-AWS-Migration"
      Environment = "Production"
      ManagedBy   = "Terraform"
    }
  }
}