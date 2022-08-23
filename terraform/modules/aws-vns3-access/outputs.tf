output "vns3_ips" {
  value = aws_eip.controller_ip.*.public_ip
}