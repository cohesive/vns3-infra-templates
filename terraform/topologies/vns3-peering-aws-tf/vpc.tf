module "aws_vpc1" {
  providers = {
    aws = "aws.vpc1_region"
  }

  source              = "../../modules/aws-vpc"
  vpc_name            = "${var.topology_name}-vpc-${var.vpc1_region}"
  vpc_dns_hostnames   = true
  vpc_cidr            = var.vpc1_cidr
  aws_region          = var.vpc1_region
  subnets_cidrs       = var.vpc1_subnets
  region_azs          = var.vpc1_region_azs
  common_tags         = var.common_tags
}

module "aws_vpc2" {
  providers = {
    aws = "aws.vpc2_region"
  }

  source              = "../../modules/aws-vpc"
  vpc_name            = "${var.topology_name}-vpc-${var.vpc2_region}"
  vpc_dns_hostnames   = true
  vpc_cidr            = var.vpc2_cidr
  aws_region          = var.vpc2_region
  subnets_cidrs       = var.vpc2_subnets
  region_azs          = var.vpc2_region_azs
  common_tags         = var.common_tags
}