locals {
    vns3_version_parts = split("-", var.vns3_version)
    vns3_version_cln = replace(element(local.vns3_version_parts, 0), ".", "")
    vns3_version_date_regex = length(local.vns3_version_parts) > 1 ? element(local.vns3_version_parts, 1) : "[0-9a-z]+"
}

data "aws_ami" "vnscubed" {
    most_recent = true
    owners = [var.vns3_account_owner]
    name_regex = "^vnscubed${local.vns3_version_cln}-${local.vns3_version_date_regex}-${var.vns3_license_type}.*"

    filter {
        name = "root-device-type"
        values = ["ebs"]
    }
}

resource "aws_network_interface" "vns3controller_eni_primary" {
  count             = length(var.subnet_ids)
  subnet_id         = element(var.subnet_ids, count.index)
  private_ips_count = 1
  source_dest_check = false
  security_groups   = [
      aws_security_group.vns3_server_sg.id
  ] 
  tags              = merge(var.common_tags, tomap({"Name" = format("%s-controller-eni-%d", var.topology_name, count.index)}))
}

resource "aws_instance" "vns3controller" {
    ami               = data.aws_ami.vnscubed.id
    count             = length(var.subnet_ids)
    instance_type     = var.vns3_instance_type
    tags              = merge(
                            var.common_tags,
                            tomap({"Name" = format("%s-vns3-%d", var.topology_name, count.index)})
                        )

    network_interface {
        network_interface_id = element(aws_network_interface.vns3controller_eni_primary.*.id, count.index)
        device_index         = 0
    }

    depends_on = [
        aws_network_interface.vns3controller_eni_primary
    ]
}