variable "topology_name" {
    default = "vns3-overlay-network"
}

variable "vns3_account_owner" {
  default = "aws-marketplace"
}

variable "vns3_version" {
  type = string
  default = "4.8"
}

variable "access_cidr" {
  type = string
  default = "54.236.197.84/32"
}

variable "state_aws_region" {
    default = "us-east-1"
    description = "EC2 Region for the VPC"
}

variable "vns3_instance_type" {
  default = "t3.small"
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  default     = {
    ManagedBy = "Terraform"
    CreatedBy = "Cohesive solutions team"
    Topology  = "vns3-overlay-network"
  }
}

variable "vpc1_cidr" {
  default = "192.168.1.0/24"
}

variable "vpc1_region"  {
  default = "us-east-1"
}

variable "vpc1_region_azs" {
  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "vpc1_subnets"  {
  description = "Subnets for VPC 1"
  type =  list
  default = [
    "192.168.1.0/25",
    "192.168.1.128/25",
  ]
}

variable "vpc2_cidr" {
  default = "192.168.2.0/24"
}

variable "vpc2_region"  {
  default = "us-west-1"
}

variable "vpc2_region_azs" {
  default = [
    "us-west-1b",
    "us-west-1c"
  ]
}

variable "vpc2_subnets"  {
  description = "Subnets for VPC 2"
  type =  list
  default = [
    "192.168.2.0/25",
    "192.168.2.128/25",
  ]
}