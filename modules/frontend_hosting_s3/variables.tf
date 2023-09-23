variable "www_domain_name" {
  type        = string
  description = "bucket name of frontend"
}

variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "iam_user_name" {
  type        = string
  description = "AWS IAM User Name"
}

variable "public_ip" {
  type        = string
  description = "EC2 instnace public IP"
}
