variable "topology_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vns3_security_group_id" {
  type = string
}

variable "controller_ids" {
  description = "Instance_ids ids for vns3 controllers"
  type        = list
  default     = []
}

variable "controller_eni_ids" {
  description = "ENI ids for vns3 controllers"
  type        = list
  default     = []
}

variable "access_cidr" {
  description = "CIDR that should be allowed access"
  type = string
}

variable "controller_route_table_id" {
  type = string
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  default     = {
    ManagedBy = "Terraform"
  }
}