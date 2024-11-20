# Create network interface for server
resource "aws_network_interface" "main" {
  subnet_id       = var.subnet_id
  security_groups = var.security_groups

  tags = {
    Name = var.vm_name
  }
}

# create dns recor for vm
resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.vm_name
  type    = "A"
  ttl     = 300
  records = [aws_network_interface.main.private_ip]
  depends_on = [
    aws_network_interface.main
  ]
}

# Create server
resource "aws_instance" "main" {
  ami           = "ami-0db00243382f611a7"
  instance_type = "t3.medium"
  availability_zone = var.availability_zone
  key_name = "main-key"
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.main.id
  }

  depends_on = [
    aws_route53_record.main
  ]

  tags = {
    "Name" = var.vm_name
  }
}