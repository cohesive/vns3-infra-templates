variable "topology_name" {
  type = "string"
}

variable "vns3_account_owner" {
  type = "string"
  default = "aws-marketplace"
}

variable "vns3_version" {
  type = "string"
  default = "4.8"
}

variable "vns3_instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {
  type = "string"
}

variable "subnet_ids" {
  description = "Array of subnets to launch controllers into. 1 Controller per subnet"
  type = list(string)
  default = []
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  default     = {
    ManagedBy = "Terraform"
  }
}