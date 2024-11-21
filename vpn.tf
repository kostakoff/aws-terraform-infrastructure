#### vpn endpoints

variable "server_certificate_arn" {
  default = "arn:aws:acm:ca-central-1:684618363085:certificate/4411cfe1-ef35-4048-8af6-f06ea79ff40c"
}

module "vpn" {
  source = "./modules/vpn"
  name = "lab-vpn"
  vpn_subnet_id = aws_subnet.lab-vpn.id
  vpc_id = aws_vpc.lab-net.id
  dns_servers = [ "10.10.0.2" ]
  client_cidr_block = "10.20.20.0/22"
  server_certificate_arn = var.server_certificate_arn
  security_group_ids = [ aws_security_group.lab-default.id ]
  subnets = [
    aws_subnet.lab0,
    aws_subnet.lab-vpn,
    aws_subnet.lab-dmz,
    aws_subnet.lab-dev-a,
    aws_subnet.lab-dev-b,
    aws_subnet.lab-dev-c,
    aws_subnet.lab-vdi
  ]
}
