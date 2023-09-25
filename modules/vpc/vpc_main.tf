data "aws_availability_zones" "available" {
  state = "available"
}

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
  vpc_id            = aws_vpc.three_tier_architecture_vpc.id
  cidr_block        = var.ec2_subnet
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
  value = aws_vpc.three_tier_architecture_vpc.id
}

output "subnet_id" {
  value = aws_subnet.ec2_subnet.id
}

resource "aws_subnet" "postgres_rds_subnets" {
  vpc_id            = aws_vpc.three_tier_architecture_vpc.id
  count             = 2
  cidr_block        = var.rds_subnet_cdir_block[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "postgres_rds_subnet_${count.index}"
  }
}

resource "aws_route_table" "postgres_rds_private_route" {
  vpc_id = aws_vpc.three_tier_architecture_vpc.id

  tags = {
    Name = "Route table for RDS"
  }
}

resource "aws_route_table_association" "postgres_rds_private_route_attach_subnet" {
  count          = 2
  subnet_id      = aws_subnet.postgres_rds_subnets[count.index].id
  route_table_id = aws_route_table.postgres_rds_private_route.id
}

resource "aws_db_subnet_group" "postgres_rds_subnet_group" {
  name       = "postgres_rds_subnet_group"
  subnet_ids = [for subnet in aws_subnet.postgres_rds_subnets : subnet.id]

  tags = {
    Name = "postgres_rds_subnet_group"
  }
}

output "rds_subnet_group_id" {
  value = aws_db_subnet_group.postgres_rds_subnet_group.id
}