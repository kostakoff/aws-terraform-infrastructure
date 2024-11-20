#### vpn subnet

# Create dev subnt 1
resource "aws_subnet" "lab-dev-a" {
  vpc_id     = aws_vpc.lab-net.id
  cidr_block = "10.10.110.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "lab-dev-a"
  }
}

# Create dev to nat route table association
resource "aws_route_table_association" "lab-dev-a2nat" {
  subnet_id = aws_subnet.lab-dev-a.id
  route_table_id = aws_route_table.lab2nat.id
}

# Create dev subnet 2
resource "aws_subnet" "lab-dev-b" {
  vpc_id     = aws_vpc.lab-net.id
  cidr_block = "10.10.120.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "lab-dev-b"
  }
}

# Create dev to nat route table association
resource "aws_route_table_association" "lab-dev-b2nat" {
  subnet_id = aws_subnet.lab-dev-b.id
  route_table_id = aws_route_table.lab2nat.id
}