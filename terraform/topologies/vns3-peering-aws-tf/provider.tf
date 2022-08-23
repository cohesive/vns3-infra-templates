provider "aws" {
  alias   = "vpc1_region"
  region  = var.vpc1_region
  version = "~> 2.8"
}

provider "aws" {
  alias = "vpc2_region"
  region = var.vpc2_region
  version = "~> 2.8"
}


terraform {
  backend "s3" {
    bucket = "cohesive-topologies-infra-states"
    key    = "peering-mesh/terraform.state"
    region = "us-east-1"
  }
}