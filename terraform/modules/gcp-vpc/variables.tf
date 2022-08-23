variable "vpc_name" {
  type = string
}

variable "subnets_cidrs" {
  type = list
  default = [
    "192.168.0.0/25",
    "192.168.0.128/25"
  ]
}

variable "region" {
    default = "us-central1"
    description = "GCP Region for the VPC"
}