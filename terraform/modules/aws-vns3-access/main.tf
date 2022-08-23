# TEMP ACCESS TO PRIVATE SUBNET(s) from restricted CIDR
resource "aws_internet_gateway" "temp_igw" {
  vpc_id = var.vpc_id
  tags   = merge(var.common_tags, tomap({ "Name" = format("%s-temp-vn3saccess-igw", var.topology_name)}))
}

resource "aws_eip" "controller_ip" {
  vpc               = true
  count             = length(var.controller_ids)
  instance          = element(var.controller_ids, count.index)
  network_interface = element(var.controller_eni_ids, count.index)
  depends_on        = [aws_internet_gateway.temp_igw]
}

resource "aws_route" "controller_support_access" {
  route_table_id         = var.controller_route_table_id
  destination_cidr_block = var.access_cidr
  gateway_id             = aws_internet_gateway.temp_igw.id

  timeouts {
    create = "10m"
  }
}

resource "aws_security_group_rule" "allow_cidr" {
  type            = "ingress"
  from_port       = 8000
  to_port         = 8000
  protocol        = "tcp"
  cidr_blocks = [var.access_cidr]
  security_group_id = var.vns3_security_group_id
}