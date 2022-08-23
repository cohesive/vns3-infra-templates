variable "vnet_name" {}

variable "resource_group_name" {}

variable "vnet_region" {
    default = "Central US"
}

variable "vnet_cidr" {
    default = "192.168.0.0/16"
    description = "CIDR subnet for VNET network"
}

variable "subnets_private" {
  type = list
  default = []
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  default     = {
    ManagedBy = "Terraform"
  }
}