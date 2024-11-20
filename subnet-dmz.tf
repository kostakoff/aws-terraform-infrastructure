#### crate DMZ

# Create dmz subnet
resource "aws_subnet" "lab-dmz" {
  vpc_id     = aws_vpc.lab-net.id
  cidr_block = "10.10.52.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "lab-dmz"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "lab-internet" {
  vpc_id = aws_vpc.lab-net.id

  tags = {
    Name = "lab-internet"
  }
}

# Create dmz route table
resource "aws_route_table" "lab2internet" {
  vpc_id = aws_vpc.lab-net.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab-internet.id
  }

  tags = {
    Name = "lab2internet"
  }
}

# Create dmz to internet route table association
resource "aws_route_table_association" "lab-dmz2internet" {
  subnet_id      = aws_subnet.lab-dmz.id
  route_table_id = aws_route_table.lab2internet.id
}

#### create DMZ NAT

# Create nat public ip
resource "aws_eip" "lab-nat" {
  depends_on = [
    aws_internet_gateway.lab-internet
  ]

  tags = {
    Name = "lab-nat"
  }
}

# Create NAT gateway
resource "aws_nat_gateway" "lab-nat" {
  allocation_id = aws_eip.lab-nat.id
  subnet_id = aws_subnet.lab-dmz.id
  
  tags = {
    "Name" = "lab-nat"
  }
}

resource "aws_route_table" "lab2nat" {
  vpc_id = aws_vpc.lab-net.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lab-nat.id
  }
}