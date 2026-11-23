terraform {
  backend "s3" {
    bucket       = "authenticfarma360-tofu-state-889629667448-us-east-1"
    key          = "staging/terraform.tfstate"
    region       = "us-east-1"
    profile      = "authenticfarma-devops"
    encrypt      = true
    use_lockfile = true
  }
}