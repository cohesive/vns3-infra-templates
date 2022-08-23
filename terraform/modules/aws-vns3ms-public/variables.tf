variable "topology_name" {
  type = string
}

variable "vns3ms_version" {
  type = string
  default = "2"
}

variable "vns3ms_account_owner" {
  type = string
  default = "aws-marketplace"
}

variable "vns3ms_instance_type" {
  default = "t2.micro"
}

variable "public_subnet_id" {
  type = string
}

variable "security_group_ids" {
  description = "A list of VPC security group IDs to place MS in"
  default     = []
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  default     = {
    ManagedBy = "Terraform"
    CreatedBy = "Cohesive solutions team"
  }
}