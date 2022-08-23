provider "aws" {
    region  = var.aws_region
    version = "~> 2.8"
}

provider "azurerm" {
    version = "=1.28.0"
}


terraform {
  backend "s3" {
    bucket = "cohesive-topologies-infra-states"
    key    = "cloud-to-cloud/terraform.state"
    region = "us-east-1"
  }
}