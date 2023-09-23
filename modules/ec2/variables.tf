variable "cidr_block" {
  type        = string
  description = "CIDR block for custom VPC"
}

variable "ec2_subnet_id" {
  type        = string
  description = "Subnet for ec2 instance"
}
variable "ami" {
  type        = string
  description = "EC2 instance image ami"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "vpc_id" {
  type        = string
  description = "custom vpc id"
}

variable "ec2_instance_count" {
  type        = string
  description = "EC2 instance count"
}
variable "av_zone" {
  type        = string
  description = "Availability zone"
}

variable "key_pair" {
  type        = string
  description = "key to login in ec2 instance"
}

variable "website_endpoint" {
  type        = string
  description = "S3 bucket endpoint for haproxy"
}