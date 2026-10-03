terraform {
  backend "s3" {
    bucket       = "oluyemi-enterprise-terraform-state-2026"
    key          = "wordpress-migration/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}