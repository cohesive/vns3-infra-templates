variable "topology_name" {
  type = string
}

variable "vns3_account_owner" {
  type = string
  default = "aws-marketplace"
}

variable "vns3_version" {
  type = string
  default = "5.0.3"
}

variable "vns3_license_type" {
  type = string
  default = "byol"
}

variable "vns3_instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {
  type = string
}

variable "client_cidrs" {
  description = "Network CIDR ranges to open controller firewall up to"
  type = list
  default = []
}

variable "access_cidr" {
  type = string
  default = ""
}

variable "access_cidrs" {
  type = list
  default = []
}

variable "peered_cidrs" {
  description = "Peered CIDR ranges to open UDP traffic for"
  type = list
  default = []
}

variable "vns3_client_sg" {
  description = "Security group containing overlay network clients"
  type = string
  default = ""
}

variable "nat_cidrs" {
  description = "NAT peered CIDR ranges to open UDP traffic for NAT-Traversal Encapsulation"
  type = list
  default = []
}

variable "ipsec_cidrs" {
  description = "IPsec configured CIDR ranges to open UDP traffic"
  type = list
  default = []
}

variable "native_ipsec_cidrs" {
  description = "Native IPsec configured CIDR ranges to open UDP traffic"
  type = list
  default = []
}

variable "subnet_ids" {
  description = "Array of subnets to launch controllers into. 1 Controller per subnet"
  type = list
  default = []
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  default     = {
    ManagedBy = "Terraform"
  }
}