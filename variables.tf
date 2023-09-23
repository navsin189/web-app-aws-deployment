variable "av_zone" {
  type        = string
  default     = "ap-south-1b"
  description = "Availability zone"
}

variable "www_domain_name" {
  type        = string
  sensitive   = true
  description = "bucket name of frontend"
}

variable "account_id" {
  type        = string
  sensitive   = true
  description = "AWS Account ID"
}

variable "iam_user_name" {
  type        = string
  sensitive   = true
  description = "AWS IAM User Name"
}

variable "cidr_block" {
  type        = string
  default     = "10.2.0.0/16"
  description = "CIDR block for custom VPC"
}

variable "ec2_subnet" {
  type        = string
  default     = "10.2.1.0/24"
  description = "Subnet for ec2 instance"
}

variable "ami" {
  type        = string
  sensitive   = true
  description = "EC2 instance image ami"
}

variable "instance_type" {
  type        = string
  sensitive   = true
  description = "EC2 instance type"
}

variable "ec2_instance_count" {
  type        = string
  default     = 1
  description = "EC2 instance count"
}

variable "key_pair" {
  type        = string
  sensitive   = true
  description = "key to login in ec2 instance"
}