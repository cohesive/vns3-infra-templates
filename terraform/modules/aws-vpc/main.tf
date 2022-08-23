resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.vpc_dns_hostnames
  enable_dns_support   = var.vpc_dns_support
  tags                 = merge(var.common_tags, tomap({ "Name" =  format("%s", var.vpc_name)}))
}

# resource "aws_default_network_acl" "main_vpc_default" {
#   default_network_acl_id = aws_vpc.main.default_network_acl_id

#   ingress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   egress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }
# }

# Subnets
resource "aws_subnet" "subnets" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.subnets_cidrs)
  cidr_block        = element(var.subnets_cidrs, count.index)
  availability_zone = element(var.region_azs, count.index % length(var.region_azs))
  tags              = merge(var.common_tags, tomap({ "Name" =  format("%s-subnet-%d", var.vpc_name ,count.index)}))
}
