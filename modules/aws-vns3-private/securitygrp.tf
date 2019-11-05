resource "aws_security_group" "vns3_server_sg" {
  name        = "${var.topology_name}-vns3-sg"
  description = "VNS3 controllers security group"
  vpc_id      = "${var.vpc_id}"

  # API access ====
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "TCP"
    self        = true
  }
  
  # Peering ports ====
  ingress {
    from_port   = 1195
    to_port     = 1197
    protocol    = "UDP"
    self        = true
  }

  ingress {
    from_port   = 500
    to_port     = 500
    protocol    = "UDP"
    self        = true
  }

  ingress {
    from_port   = 4500
    to_port     = 4500
    protocol    = "UDP"
    self        = true
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
  #   protocol    = "50"
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
  }
}