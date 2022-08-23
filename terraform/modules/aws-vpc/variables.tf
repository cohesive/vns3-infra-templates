variable "vpc_name" {}

variable "aws_region" {
    default = "us-east-1"
    description = "EC2 Region for the VPC"
}

variable "vpc_cidr" {
    default = "192.168.0.0/24"
    description = "CIDR subnet for VPC network"
}

variable "subnets_cidrs" {
  type = list
  default = [
    "192.168.0.0/25",
    "192.168.0.128/25"
  ]
}

variable "vpc_dns_support" {
    default = true
    description = "DNS support for VPC"
}

variable "vpc_dns_hostnames" {
    default = false
    description = "DNS hostnames support for VPC"
}

variable "region_azs" {
  description = "A list of Availability zones in the region"
  type        = list
  default     = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  default     = {
    ManagedBy = "Terraform"
  }
}