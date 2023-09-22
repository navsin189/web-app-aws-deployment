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
