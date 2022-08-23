variable "project" {
  description = "GCP Project to launch in"
}

variable "region" {
  default = "us-central1"
  description = "GCP Region for the VPC"
}

variable "topology_name" {
  type = string
  default = "cn-simple-topo"
}

variable "vpc_cidr" {
  type = string
  default = "10.10.0.0/24"
}

variable "subnets_cidrs" {
  type = list
  default = [
    "10.10.0.0/25",
    "10.10.0.128/25"
  ]
}

variable "vns3_image_id" {
  default = ""
}

variable "vns3_instance_type" {
  default = "e2-small"
}

variable "admin_cidrs" {
  type = list
  default = []
}

variable "routeable_internet_cidrs" {
  type = list
  default = ["0.0.0.0/0"]
}