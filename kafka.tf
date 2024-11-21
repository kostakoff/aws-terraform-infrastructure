#### vm's

module "dev-kafka" {
  source = "./modules/kafka"
  name = "dev-kafka"
  subnets = [
    aws_subnet.lab-dev-a.id,
    aws_subnet.lab-dev-b.id,
    aws_subnet.lab-dev-c.id
  ]
  security_groups = [aws_security_group.lab-default.id]
}
