resource "aws_db_instance" "postgres_rds" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "14.7"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.postgres_rds_security_group.id] #to pass security from custom VPC
  db_subnet_group_name   = var.rds_subnet_group_id

}

resource "aws_security_group" "postgres_rds_security_group" {
  name        = "postgres-sg"
  description = "Allow EC2 instances to connect"
  vpc_id      = var.vpc_id


  ingress {
    description = "Allow postgres traffic from ec2 instance"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.ec2_subnet]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "database_endpoint" {
  description = "the endpoint of database"
  value       = aws_db_instance.postgres_rds.address
}
output "database_port" {
  description = "the port of database"
  value       = aws_db_instance.postgres_rds.port
}