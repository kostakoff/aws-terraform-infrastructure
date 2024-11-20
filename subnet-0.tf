#### 0 subnet

# Create default subnet
resource "aws_subnet" "lab0" {
  vpc_id     = aws_vpc.lab-net.id
  cidr_block = "10.10.0.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "lab0"
  }
}
