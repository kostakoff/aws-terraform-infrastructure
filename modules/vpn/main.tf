resource "aws_ec2_client_vpn_endpoint" "main" {
  description            = "corporate vpn"
  server_certificate_arn = var.server_certificate_arn
  client_cidr_block      = var.client_cidr_block
  vpn_port = 1194
  transport_protocol = "udp"
  self_service_portal = "disabled"
  vpc_id = var.vpc_id
  security_group_ids = var.security_group_ids
  dns_servers = var.dns_servers

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.server_certificate_arn
  }

  connection_log_options {
    enabled               = false
  }

  tags = {
    Name = var.name
  }
}

resource "aws_ec2_client_vpn_network_association" "main" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  subnet_id              = var.vpn_subnet_id
}

locals {
  subnets_map = { for subnet in var.subnets : subnet.tags.Name => subnet }
}

resource "aws_ec2_client_vpn_authorization_rule" "main" {
  for_each = local.subnets_map
  
  description = each.key
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  target_network_cidr    = each.value.cidr_block
  authorize_all_groups   = true
}
