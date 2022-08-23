
output "vns3_instance_ids" {
  value = aws_instance.vns3controllers.*.id
}

output "vns3_ami_name" {
  value = data.aws_ami.vnscubed.name
}

output "vns3_ami_id" {
  value = data.aws_ami.vnscubed.id
}

output "vns3_sg" {
  value = aws_security_group.vns3_server_sg.id
}

output "vns3_azs" {
  value = aws_instance.vns3controllers.*.availability_zone
}

output "vns3_network_interfaces" {
  value = aws_network_interface.vns3controller_enis.*.id
}

output "vns3_private_ips" {
  value = aws_network_interface.vns3controller_enis.*.private_ips
}

output "vns3_public_ips" {
  value = aws_eip.controller_ips.*.public_ip
}

output "vns3_primary_ips" {
  value = aws_instance.vns3controllers.*.private_ip
}

output "vns3_hostnames" {
  value = aws_eip.controller_ips.*.public_dns
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}
