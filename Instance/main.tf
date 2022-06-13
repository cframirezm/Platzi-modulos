
resource "aws_instance" "cframirez-platzi-instance" {
  ami = var.ami_id
  instance_type   = var.instance_type
  tags            = var.tags
  security_groups = ["${aws_security_group.ssh_conection.name}"]
}

resource "aws_security_group" "ssh_conection" {
  name = var.sg_name
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks

    }
  }
}

resource "aws_eip" "ip_elastica_1" {
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.cframirez-platzi-instance.id
  allocation_id = aws_eip.ip_elastica_1.id
}

