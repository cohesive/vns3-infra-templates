data "aws_ami" "vns3ms" {
    most_recent = true
    owners = [var.vns3ms_account_owner]

    filter {
        name   = "name"
        values = ["vns3ms${replace(var.vns3ms_version, ".", "")}*"]
    }
    
    filter {
        name = "root-device-type"
        values = ["ebs"]
    }
}

resource "aws_network_interface" "vns3ms_eni" {
  subnet_id         = var.public_subnet_id
  security_groups   = var.security_group_ids
  tags              = merge(var.common_tags, tomap({ "Name" =  format("%s-ms-eni", var.topology_name)}))
}

resource "aws_instance" "vns3ms" {
    ami                    = data.aws_ami.vns3ms.id
    instance_type          = var.vns3ms_instance_type
    tags                   = merge(
                                var.common_tags,
                                tomap({ "Name" =  format("%s-ms", var.topology_name)})
                            )

    network_interface {
        network_interface_id = aws_network_interface.vns3ms_eni.id
        device_index         = 0
    }

    depends_on = [aws_network_interface.vns3ms_eni]
}

resource "aws_eip" "vns3ms_ip" {
  vpc               = true
  instance          = aws_instance.vns3ms.id
  network_interface = aws_network_interface.vns3ms_eni.id
}
