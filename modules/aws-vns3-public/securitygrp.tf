resource "aws_security_group" "vns3_server_sg" {
  name        = "${var.topology_name}-vns3-sg"
  description = "VNS3 controllers security group"
  vpc_id      = "${var.vpc_id}"
  tags        = "${merge(var.common_tags, map("Name", format("%s-vns3-sg", var.topology_name)))}"

  # API access ====
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "TCP"
    self        = true
    description = ""
  }

  # Peering ports ====
  ingress {
    from_port   = 1195
    to_port     = 1203
    protocol    = "UDP"
    self        = true
    description = ""
  }

  ingress {
    from_port   = 500
    to_port     = 500
    protocol    = "UDP"
    self        = true
    description = ""
  }

  ingress {
    from_port   = 4500
    to_port     = 4500
    protocol    = "UDP"
    self        = true
    description = ""
  }

  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "TCP"
    cidr_blocks     = ["${var.access_cidr}"]
    description     = ""
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = "${var.client_cidrs}"
    description     = ""
  }

  # ingress {
  #   from_port   = 500
  #   to_port     = 500
  #   protocol    = "UDP"
  #   cidr_blocks = "Your ipsec device"
  # }

  # ingress {
  #   from_port   = 500
  #   to_port     = 500
  #   protocol    = "50" # used with native IPsec
  #   cidr_blocks = "Your ipsec device"
  # }

  # ingress {
  #   from_port   = 4500
  #   to_port     = 4500
  #   protocol    = "UDO" # use with NAT-Traversal Encapsulation
  #   cidr_blocks = "Your ipsec device"
  # }

  # # Overlay network from clients
  # ingress {
  #   from_port   = 1194
  #   to_port     = 1194
  #   protocol    = "UDP"
  #   security_groups = ["${aws_security_group.vns3_client_sg.id}"]
  # }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description     = ""
  }
}