#### vm's

module "dev-vm1" {
  source = "./modules/appvm"
  vm_name = "dev-vm1.myltd.lab"
  subnet_id = aws_subnet.lab-dev-a.id
  security_groups = [aws_security_group.lab-default.id]
  availability_zone = aws_subnet.lab-dev-a.availability_zone
  zone_id = aws_route53_zone.lab-net.id
}
