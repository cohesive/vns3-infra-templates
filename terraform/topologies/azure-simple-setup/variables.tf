variable "topology_name" {
  default = "cn-topo-azure"
}

variable "user" {
  type = string
}

variable "access_cidr" {
  type = string
  description = "CIDR that requires access. This might be your company VPN network or a network operations center"
  default = "54.236.197.84/32"
}

variable azure_vns3_vm_size {
  default = "Standard_A2_v2"
}

variable "azure_instance_password" {
  type = string
  default = "910wjfnKASKwnfi0wdf" // not usable in any case
}

variable "azure_resource_group_name" {
  default = "cn-topo-group"
}

variable "vnet_region" {
  default = "West US 2"
}

variable "vnet_cidr" {
  default = "10.105.76.0/24"
  description = "CIDR subnet for VNET network"
}

variable "azure_subnets" {
  type = list
  default = [
    "10.105.76.0/28",
    "10.105.76.16/28"
  ]
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  default     = {
    ManagedBy = "Terraform"
    CreatedBy = "Cohesive solutions team"
    Topology  = "cn-topo-azure"
  }
}

variable "vns3_version" {
  type = string
  default = "4.11"
}