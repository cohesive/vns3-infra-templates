# Routing
## Private subnets

resource "aws_route_table" "subnets_private" {
  vpc_id           = "${aws_vpc.main.id}"
  propagating_vgws = []
  tags             = "${merge(var.common_tags, map("Name", format("%s-rt-private", var.vpc_name)))}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.subnets_private)}"
  subnet_id      = "${element(aws_subnet.subnets_private.*.id, count.index)}"
  route_table_id = "${aws_route_table.subnets_private.id}"
}