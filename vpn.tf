variable "server_certificate_arn" {
  default = "arn:aws:acm:ca-central-1:684618363085:certificate/4411cfe1-ef35-4048-8af6-f06ea79ff40c"
}

resource "aws_ec2_client_vpn_endpoint" "vpn" {
  description            = "corporate vpn"
  server_certificate_arn = var.server_certificate_arn
  client_cidr_block      = "10.20.20.0/22"
  vpn_port = 1194
  transport_protocol = "udp"
  self_service_portal = "disabled"
  vpc_id = aws_vpc.lab-net.id
  security_group_ids = [ aws_security_group.lab-default.id ]
  dns_servers = [ "10.10.0.2" ]

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.server_certificate_arn
  }

  connection_log_options {
    enabled               = false
  }

  tags = {
    Name = "lab-vpn"
  }
}

resource "aws_ec2_client_vpn_network_association" "vpn" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  subnet_id              = aws_subnet.lab-vpn.id
}

resource "aws_ec2_client_vpn_authorization_rule" "lab0" {
  description = "lab0"
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = aws_subnet.lab0.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "lab-vpn" {
  description = "lab-vpn"
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = aws_subnet.lab-vpn.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "lab-dmz" {
  description = "lab-dmz"
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = aws_subnet.lab-dmz.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "lab-dev-a" {
  description = "lab-dev-a"
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = aws_subnet.lab-dev-a.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "lab-dev-b" {
  description = "lab-dev-b"
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = aws_subnet.lab-dev-b.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "lab-vdi" {
  description = "lab-vdi"
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = aws_subnet.lab-vdi.cidr_block
  authorize_all_groups   = true
}
