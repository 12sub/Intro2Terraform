provider "aws" {
  region = "us-east-1"
}
#Create a vpc
resource "aws_vpc" "live-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "live-vpc"
  }
}
#Setup subnet
resource "aws_subnet" "live-subnet" {
  vpc_id     = aws_vpc.live-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "live-subnet"
  }
}
#setup internet gateway
resource "aws_internet_gateway" "gateways" {
  vpc_id = aws_vpc.live-vpc.id

  tags = {
    Name = "main"
  }
}
#setup route table with internet gateway
resource "aws_route_table" "route1" {
  vpc_id = aws_vpc.live-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateways.id
  }
   tags = {
    Name = "route-table-1"
  }
}
#Setup association for route table
resource "aws_route_table_association" "alpha" {
  subnet_id      = aws_subnet.live-subnet.id
  route_table_id = aws_route_table.route1.id
  depends_on     = [aws_route_table.route1, aws_subnet.live-subnet] 
}
#setup security group
resource "aws_security_group" "sec-group1" {
  name        = "Project2"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.live-vpc.id
  ingress {     
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Project2"
  }
}
# resource "aws_vpc_security_group_ingress_rule" "allow_ipv4" {
#   security_group_id = aws_security_group.sec-group1.id

#   cidr_ipv4   = "0.0.0.0/0"
#   from_port   = 443
#   ip_protocol = "tcp"
#   to_port     = 443
# }
# resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
#   security_group_id = aws_security_group.sec-group1.id

#   cidr_ipv4   = "0.0.0.0/0"
#   from_port   = 22
#   ip_protocol = "ssh"
#   to_port     = 22
# }
# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.sec-group1.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

# resource "aws_vpc_security_group_egress_rule" "allow_ssh" {
#   security_group_id = aws_security_group.sec-group1.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

#setup instance
resource "aws_instance" "technical" {
  ami           = "ami-04e5276ebb8451442"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.live-subnet.id
  vpc_security_group_ids = [aws_security_group.sec-group1.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello World" >> /Desktop/hello.txt
                EOF

  tags = {
    Name = "Project2"
  }
}