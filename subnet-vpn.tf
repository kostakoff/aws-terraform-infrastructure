#### vpn subnet

# Create vpn servers subnet
resource "aws_subnet" "lab-vpn" {
  vpc_id     = aws_vpc.lab-net.id
  cidr_block = "10.10.105.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "lab-vpn"
  }
}

# Create vpn to nat route table association
resource "aws_route_table_association" "lab-vpn2nat" {
  subnet_id = aws_subnet.lab-vpn.id
  route_table_id = aws_route_table.lab2nat.id
}
