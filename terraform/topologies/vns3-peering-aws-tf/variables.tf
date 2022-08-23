variable "topology_name" {
  default = "vns3-peering-mesh"
}

variable "vns3_account_owner" {
  default = "aws-marketplace"
}

variable "vns3_version" {
  type = string
  default = "4.9"
}

variable "access_cidr" {
  type = string
  default = "54.236.197.84/32"
}

variable "state_aws_region" {
    default = "us-east-1"
    description = "EC2 Region for the topology state"
}

variable "vns3_instance_type" {
  default = "t3.small"
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  default     = {
    ManagedBy = "Terraform"
    CreatedBy = "Cohesive solutions team"
    Topology  = "vns3-peering-mesh"
  }
}

variable "vpc1_cidr" {
  default = "10.0.1.0/24"
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
    "10.0.1.0/25",
    "10.0.1.128/25",
  ]
}

variable "vpc2_cidr" {
  default = "10.0.2.0/24"
}

variable "vpc2_region"  {
  default = "us-west-2"
}

variable "vpc2_region_azs" {
  default = [
    "us-west-2b",
    "us-west-2c"
  ]
}

variable "vpc2_subnets"  {
  description = "Subnets for VPC 2"
  type =  list
  default = [
    "10.0.2.0/25",
    "10.0.2.128/25",
  ]
}