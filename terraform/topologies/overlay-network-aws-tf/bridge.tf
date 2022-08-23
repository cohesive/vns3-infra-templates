// Security group rules for VNS3 controllers
resource "aws_security_group_rule" "vpc1_allow_peer_vpc2" {
  provider        = "aws.vpc1_region"
  type            = "ingress"
  from_port       = 1195
  to_port         = 1203
  protocol        = "UDP"
  cidr_blocks = [module.aws_vpc2.vpc_cidr]
  security_group_id = module.vns3_vpc1.vns3_sg
}

resource "aws_security_group_rule" "vpc2_allow_peer_vpc1" {
  provider        = "aws.vpc2_region"
  type            = "ingress"
  from_port       = 1195
  to_port         = 1203
  protocol        = "UDP"
  cidr_blocks = [module.aws_vpc1.vpc_cidr]
  security_group_id = module.vns3_vpc2.vns3_sg
}

# // AWS routing for bridge
resource "aws_route" "vpc1_igw" {
  provider                    = "aws.vpc1_region"
  route_table_id              = module.aws_vpc1.route_table_id
  destination_cidr_block      = "0.0.0.0/0"
  gateway_id                  = module.vns3_vpc1.internet_gateway_id

  timeouts {
    create = "10m"
  }
}

resource "aws_route" "vpc1_to_vpc2" {
  provider                    = "aws.vpc1_region"
  route_table_id              = module.aws_vpc1.route_table_id
  destination_cidr_block      = module.aws_vpc2.vpc_cidr
  network_interface_id        = element(module.vns3_vpc1.vns3_network_interfaces, 0)

  timeouts {
    create = "10m"
  }
}

resource "aws_route" "vpc2_igw" {
  provider                    = "aws.vpc2_region"
  route_table_id              = module.aws_vpc2.route_table_id
  destination_cidr_block      = "0.0.0.0/0"
  gateway_id                  = module.vns3_vpc2.internet_gateway_id

  timeouts {
    create = "10m"
  }
}

resource "aws_route" "vpc2_to_vpc1" {
  provider                    = "aws.vpc2_region"
  route_table_id              = module.aws_vpc2.route_table_id
  destination_cidr_block      = module.aws_vpc1.vpc_cidr
  network_interface_id        = element(module.vns3_vpc2.vns3_network_interfaces, 0)

  timeouts {
    create = "10m"
  }
}
