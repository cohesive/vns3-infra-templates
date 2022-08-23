// Peering connection
resource "aws_vpc_peering_connection" "vpc1" {
  provider      = "aws.vpc1_region"
  vpc_id        = module.aws_vpc1.vpc_id
  peer_vpc_id   = module.aws_vpc2.vpc_id
  peer_owner_id = module.aws_vpc2.owner_id
  peer_region   = var.vpc2_region
  auto_accept   = false

  tags = {
    Side = "Requester"
    Topology = var.topology_name
  }
}

resource "aws_vpc_peering_connection_accepter" "vpc2_peer" {
  provider                  = "aws.vpc2_region"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
    Topology = var.topology_name
  }
}

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

// AWS routing for bridge
resource "aws_route" "vpc1" {
  provider                    = "aws.vpc1_region"
  route_table_id              = module.aws_vpc1.route_table_id
  destination_cidr_block      = module.aws_vpc2.vpc_cidr
  vpc_peering_connection_id   = aws_vpc_peering_connection.vpc1.id

  timeouts {
    create = "10m"
  }
}

resource "aws_route" "vpc2" {
  provider                    = "aws.vpc2_region"
  route_table_id              = module.aws_vpc2.route_table_id
  destination_cidr_block      = module.aws_vpc1.vpc_cidr
  vpc_peering_connection_id   = aws_vpc_peering_connection_accepter.vpc2_peer.id

  timeouts {
    create = "10m"
  }
}
