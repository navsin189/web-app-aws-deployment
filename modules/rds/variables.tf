variable "db_username" {
  type        = string
  description = "database username"
}

variable "db_password" {
  type        = string
  description = "database password"
}
variable "db_name" {
  type        = string
  description = "database name"
}

variable "ec2_subnet" {
  type        = string
  description = "subnet of EC2 instances"
}

variable "rds_subnet_group_id" {
  type        = string
  description = "RDS subnet group id"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}