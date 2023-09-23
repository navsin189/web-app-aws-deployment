resource "aws_vpc" "three_tier_architecture_vpc" {
  cidr_block = var.cidr_block
}

resource "aws_internet_gateway" "ec2_internet_gateway" {
  vpc_id = aws_vpc.three_tier_architecture_vpc.id

  tags = {
    ig = "ec2"
  }
}

resource "aws_subnet" "ec2_subnet" {
  vpc_id     = aws_vpc.three_tier_architecture_vpc.id
  cidr_block = var.ec2_subnet
  availability_zone = var.av_zone
  tags = {
    subnet = "ec2"
  }
}

resource "aws_route_table" "ec2_route_table" {
  vpc_id = aws_vpc.three_tier_architecture_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2_internet_gateway.id
  }
  tags = {
    Name = "ec2 route table"
  }
}

resource "aws_route_table_association" "ec2_route_table_association" {
  subnet_id      = aws_subnet.ec2_subnet.id
  route_table_id = aws_route_table.ec2_route_table.id
}

output "vpc_id" {
  value   =   aws_vpc.three_tier_architecture_vpc.id
}

output "subnet_id" {
  value   =   aws_subnet.ec2_subnet.id
}