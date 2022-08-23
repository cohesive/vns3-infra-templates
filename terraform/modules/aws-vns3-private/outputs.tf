
output "vns3_instance_ids" {
  value = aws_instance.vns3controller.*.id
}
output "vns3_azs" {
  value = aws_instance.vns3controller.*.availability_zone
}

output "vns3_ami_name" {
  value = data.aws_ami.vnscubed.name
}

output "vns3_sg" {
  value = aws_security_group.vns3_server_sg.id
}

output "vns3_primary_network_interfaces" {
  value = aws_network_interface.vns3controller_eni_primary.*.id
}

output "vns3_private_primary_ips" {
  value = aws_network_interface.vns3controller_eni_primary.*.private_ips
}

output "vns3_primary_ips" {
  value = aws_instance.vns3controller.*.private_ip
}