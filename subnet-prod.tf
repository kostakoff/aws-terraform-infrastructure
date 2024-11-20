#### vpn subnet

# Create prod 1 subnet
resource "aws_subnet" "lab-prod-a" {
  vpc_id     = aws_vpc.lab-net.id
  cidr_block = "10.10.210.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "lab-prod-a"
  }
}

# Create prod to nat route table association
resource "aws_route_table_association" "lab-prod-a2nat" {
  subnet_id = aws_subnet.lab-prod-a.id
  route_table_id = aws_route_table.lab2nat.id
}

# Create prod 2 subnet
resource "aws_subnet" "lab-prod-b" {
  vpc_id     = aws_vpc.lab-net.id
  cidr_block = "10.10.220.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "lab-prod-b"
  }
}

# Create prod to nat route table association
resource "aws_route_table_association" "lab-prod-b2nat" {
  subnet_id = aws_subnet.lab-prod-b.id
  route_table_id = aws_route_table.lab2nat.id
}

# Create prod 3 subnet
resource "aws_subnet" "lab-prod-c" {
  vpc_id     = aws_vpc.lab-net.id
  cidr_block = "10.10.230.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "lab-prod-c"
  }
}

# Create prod to nat route table association
resource "aws_route_table_association" "lab-prod-c2nat" {
  subnet_id = aws_subnet.lab-prod-c.id
  route_table_id = aws_route_table.lab2nat.id
}
