# Routing
## Private subnets

resource "aws_route_table" "subnets" {
  vpc_id           = aws_vpc.main.id
  propagating_vgws = []
  tags             = merge(var.common_tags, tomap({ "Name" =  format("%s-rt", var.vpc_name)}))
}

resource "aws_route_table_association" "subnets" {
  count          = length(aws_subnet.subnets)
  subnet_id      = element(aws_subnet.subnets.*.id, count.index)
  route_table_id = aws_route_table.subnets.id
}