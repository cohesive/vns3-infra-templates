variable "topology_name" {
  default = "cntopos-multicloud-am-az"
}

variable "vnet_name" {
  default = "vnet-cntopos-multicloud-am-az"
}

variable "access_cidr" {
  type = string
  description = "CIDR that requires access. This might be your company VPN network or a network operations center"
  default = "54.236.197.84/32"
}

variable azure_vns3_vm_size {
  default = "Standard_B1s"
}

variable "azure_instance_password" {
  type = string
  default = "testtest1234?Cohesive!"
}

variable "azure_resource_group_name" {
  default = "cn-topos-multicloud-am-az"
}

variable "vnet_region" {
  default = "Central US"
}

variable "vnet_cidr" {
  default = "10.100.1.0/24"
  description = "CIDR subnet for VNET network"
}

variable "azure_subnets" {
  type = list
  default = [
    "10.100.1.0/26",
    "10.100.1.64/26",
    "10.100.1.128/26"
  ]
}

variable "vpc_name" {
  default = "vpc-cntopos-multicloud-am-az"
}

variable "aws_vns3_instance_type" {
  default = "t3.small"
}

variable "aws_region" {
  default = "us-east-1"
  description = "EC2 Region for the VPC"
}

variable "vpc_cidr" {
  default = "10.100.2.0/24"
  description = "CIDR subnet for VPC network"
}

variable "aws_subnets" {
  type = list
  default = [
    "10.100.2.0/26",
    "10.100.2.64/26",
    "10.100.2.128/26"
  ]
}

variable "aws_region_azs" {
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

variable "aws_vns3_version" {
  type = string
  default = "4.8"
}