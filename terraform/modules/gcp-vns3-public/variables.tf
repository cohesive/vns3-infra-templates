variable "topology_name" {
  type = string
}

variable "network_id" {
  type = string
  description = ""
}

variable "vns3_subnet_ids" {
  type = list
  default = []
}

variable "vns3_subnet_zones" {
  type = list
  default = []
}

variable "vns3_image_id" {
  type = string
}

variable "region" {
  default = "us-central1"
  description = "GCP Region for the VPC"
}

variable "vns3_count" {
  type = number
  default = 2
}

variable "vns3_instance_type" {
  type = string
  default = "e2-small"
}

variable "networking_tier" {
  type = string
  default = "STANDARD"
}

variable "routeable_internet_cidrs" {
  type = list
  default = []
}

variable "admin_cidrs" {
  type = list
  default = []
}

variable "overlay_cidrs" {
  type = list
  default = []
}

variable "ipsec_cidrs" {
  type = list
  default = []
}

variable "nat_ipsec_cidrs" {
  type = list
  default = []
}

variable "native_ipsec_cidrs" {
  type = list
  default = []
}

