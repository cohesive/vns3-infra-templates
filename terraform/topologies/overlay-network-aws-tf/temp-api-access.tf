resource "aws_security_group_rule" "vpc1_allow_fetch_keyset" {
  provider        = "aws.vpc1_region"
  type            = "ingress"
  from_port       = 8000
  to_port         = 8000
  protocol        = "TCP"
  cidr_blocks = [for ip in module.vns3_vpc2.vns3_public_ips : format("%s/32", ip)]
  security_group_id = module.vns3_vpc1.vns3_sg
}

resource "aws_security_group_rule" "vpc2_allow_fetch_keyset" {
  provider        = "aws.vpc2_region"
  type            = "ingress"
  from_port       = 8000
  to_port         = 8000
  protocol        = "TCP"
  cidr_blocks = [for ip in module.vns3_vpc1.vns3_public_ips : format("%s/32", ip)]
  security_group_id = module.vns3_vpc2.vns3_sg
}