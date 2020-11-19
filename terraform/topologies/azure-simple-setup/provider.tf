provider "azurerm" {
    version = "=1.28.0"
}


terraform {
  backend "s3" {
    bucket = "cohesive-infra-uat"
    key    = "testing/azure-basic-setup/terraform.state"
    region = "us-east-1"
  }
}