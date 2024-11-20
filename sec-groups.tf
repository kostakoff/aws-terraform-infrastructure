# Create default security group for ec2
resource "aws_security_group" "lab-default" {
  name = "lab-default-security-group"
  description = "lab-default-security-group"
  vpc_id = aws_vpc.lab-net.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  tags = {
    "Name" = "lab-default"
  }
}