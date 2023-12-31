variable "cidr_block" {
  type        = string
  description = "CIDR block for custom VPC"
}

variable "ec2_subnet" {
  type        = string
  description = "Subnet for ec2 instance"
}

variable "av_zone" {
  type        = string
  description = "Availability zone"
}

variable "rds_subnet_cdir_block" {
  type        = list(string)
  description = "list of subnets"
}