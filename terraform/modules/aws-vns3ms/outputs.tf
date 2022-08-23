output "vns3ms_eni_id" {
    value = aws_network_interface.vns3ms_eni.id
}

output "vns3ms_id" {
    value = aws_instance.vns3ms.id
}

output "vns3ms_ami_name" {
  value = data.aws_ami.vns3ms.name
}
