data "aws_ami" "vnscubed" {
    most_recent = true
    owners = ["${var.vns3_account_owner}"]
    name_regex = "^vnscubed${replace(var.vns3_version, ".", "")}.*${var.vns3_license_type}.*"
    
    filter {
        name = "root-device-type"
        values = ["ebs"]
    }
}

resource "aws_network_interface" "vns3controller_enis" {
  count             = "${length(var.subnet_ids)}"
  subnet_id         = "${element(var.subnet_ids, count.index)}"
  private_ips_count = 1
  source_dest_check = false
  security_groups   = [
      "${aws_security_group.vns3_server_sg.id}"
  ] 
  tags              = "${merge(var.common_tags, map("Name", format("%s-controller-eni-%d", var.topology_name, count.index)))}"
}

resource "aws_instance" "vns3controllers" {
    ami               = "${data.aws_ami.vnscubed.id}"
    count             = "${length(var.subnet_ids)}"
    instance_type     = "${var.vns3_instance_type}"
    tags              = "${merge(
                            var.common_tags,
                            map("Name", format("%s-vns3-%d", var.topology_name, count.index))
                        )}"

    network_interface {
        network_interface_id = "${element(aws_network_interface.vns3controller_enis.*.id, count.index)}"
        device_index         = 0
    }

    depends_on = ["aws_network_interface.vns3controller_enis"]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
  tags   = "${merge(var.common_tags, map("Name", format("%s-vn3saccess-igw", var.topology_name)))}"
}

resource "aws_eip" "controller_ips" {
  vpc               = true
  count             = "${length(aws_instance.vns3controllers)}"
  instance          = "${element(aws_instance.vns3controllers.*.id, count.index)}"
  network_interface = "${element(aws_network_interface.vns3controller_enis.*.id, count.index)}"
  depends_on        = ["aws_internet_gateway.igw"]
}

resource "aws_route" "controller_support_access" {
  route_table_id         = "${var.vpc_route_table_id}"
  destination_cidr_block = "${var.access_cidr}"
  gateway_id             = "${aws_internet_gateway.igw.id}"

  timeouts {
    create = "10m"
  }
}