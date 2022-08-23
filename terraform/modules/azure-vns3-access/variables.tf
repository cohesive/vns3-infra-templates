variable "topology_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "route_table_name" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "controller_ids" {
  description = "VM ids ids for vns3 controllers"
  type        = list
  default     = []
}

variable "access_cidr" {
  description = "CIDR that should be allowed access"
  type = string
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  default     = {
    ManagedBy = "Terraform"
  }
}