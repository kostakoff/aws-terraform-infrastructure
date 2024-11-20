#### create base

# Create VPC local network
resource "aws_vpc" "lab-net" {
  cidr_block = "10.10.0.0/16"

  enable_dns_support = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "lab-net"
  }
}

# create lab dns zone
resource "aws_route53_zone" "lab-net" {
  name = "myltd.lab"

  vpc {
    vpc_id = aws_vpc.lab-net.id
  }
}

data "aws_availability_zones" "available" {}
