provider "aws" {
  profile             = "authenticfarma-devops"
  region              = "us-east-1"
  allowed_account_ids = ["889629667448"]

  default_tags {
    tags = {
      Environment = "bootstrap"
      ManagedBy   = "OpenTofu"
      Project     = "AuthenticFarma360"
    }
  }
}