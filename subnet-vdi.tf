#### vpn subnet

# Create vdi servers subnet
resource "aws_subnet" "lab-vdi" {
  vpc_id     = aws_vpc.lab-net.id
  cidr_block = "10.10.200.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "lab-vdi"
  }
}

# Create vdi to nat route table association
resource "aws_route_table_association" "lab-vdi2nat" {
  subnet_id = aws_subnet.lab-vdi.id
  route_table_id = aws_route_table.lab2nat.id
}
