resource "aws_security_group" "vns3_server_sg" {
  name        = "${var.topology_name}-vns3-sg"
  description = "VNS3 controllers security group"
  vpc_id      = var.vpc_id
  tags        = merge(var.common_tags, tomap({"Name" = format("%s-vns3-sg", var.topology_name)}))
}


resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vns3_server_sg.id
}

resource "aws_security_group_rule" "internal_vns3_app_access" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "TCP"
  self              = true
  security_group_id = aws_security_group.vns3_server_sg.id
}

resource "aws_security_group_rule" "internal_vns3_peering_access" {
  type              = "ingress"
  from_port         = 1195
  to_port           = 1203
  protocol          = "UDP"
  self              = true
  security_group_id = aws_security_group.vns3_server_sg.id
}

resource "aws_security_group_rule" "internal_vns3_ipsec_4500_access" {
  type              = "ingress"
  from_port         = 4500
  to_port           = 4500
  protocol          = "UDP"
  self              = true
  security_group_id = aws_security_group.vns3_server_sg.id
}

resource "aws_security_group_rule" "internal_vns3_ipsec_500_access" {
  type              = "ingress"
  from_port         = 500
  to_port           = 500
  protocol          = "UDP"
  self              = true
  security_group_id = aws_security_group.vns3_server_sg.id
}

resource "aws_security_group_rule" "peered_networks_access" {
  count             = length(var.peered_cidrs) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = 1195
  to_port           = 1203
  protocol          = "UDP"
  cidr_blocks       = var.peered_cidrs
  security_group_id = aws_security_group.vns3_server_sg.id
}

resource "aws_security_group_rule" "client_networks_access" {
  count             = length(var.client_cidrs) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.client_cidrs
  security_group_id = aws_security_group.vns3_server_sg.id
}

// Deprecated
resource "aws_security_group_rule" "client_api_access" {
  count             = var.access_cidr != "" ? 1 : 0
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "TCP"
  cidr_blocks       = [var.access_cidr]
  security_group_id = aws_security_group.vns3_server_sg.id
}

resource "aws_security_group_rule" "clients_api_access" {
  count             = length(var.access_cidrs) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "TCP"
  cidr_blocks       = var.access_cidrs
  security_group_id = aws_security_group.vns3_server_sg.id
}


resource "aws_security_group_rule" "nat_network_access" {
  count             = length(var.nat_cidrs) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = 4500
  to_port           = 4500
  protocol          = "UDP"
  cidr_blocks       = var.nat_cidrs
  security_group_id = aws_security_group.vns3_server_sg.id
}

resource "aws_security_group_rule" "overlay_clients_access" {
  count             = var.vns3_client_sg != "" ? 1 : 0
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "UDP"
  cidr_blocks       = [var.vns3_client_sg]
  security_group_id = aws_security_group.vns3_server_sg.id
}


resource "aws_security_group_rule" "ipsec_cidrs_access" {
  count             = length(var.ipsec_cidrs) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = 500
  to_port           = 500
  protocol          = "UDP"
  cidr_blocks       = var.ipsec_cidrs
  security_group_id = aws_security_group.vns3_server_sg.id
}

resource "aws_security_group_rule" "native_ipsec_cidrs_access" {
  count             = length(var.native_ipsec_cidrs) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "50"
  cidr_blocks       = var.native_ipsec_cidrs
  security_group_id = aws_security_group.vns3_server_sg.id
}