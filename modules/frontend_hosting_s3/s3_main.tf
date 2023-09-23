data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket" "w3_frontend_hosting" {
  bucket = var.www_domain_name

  tags = {
    domain        = var.www_domain_name
    Environment   = "production"
    server        = "main"
  }
}

resource "aws_s3_bucket_versioning" "w3_frontend_hosting_versioning" {
  bucket = aws_s3_bucket.w3_frontend_hosting.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "w3_frontend_hosting_website_conf" {
  bucket = aws_s3_bucket.w3_frontend_hosting.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "login/"
    }
    redirect {
      replace_key_prefix_with = "signin/"
    }
  }
}

resource "aws_s3_bucket_policy" "w3_frontend_hosting_policy" {
  bucket = aws_s3_bucket.w3_frontend_hosting.id
  policy = templatefile("./modules/frontend_hosting_s3/domain-hosting-policy.json", { bucket = var.www_domain_name,public_ip = var.public_ip})
}

# resource "aws_s3_bucket_acl" "w3_frontend_hosting_acl" {
#   bucket = aws_s3_bucket.w3_frontend_hosting.id
#   acl    = "public-read"
# }

output "w3_frontend_hosting_endpoint" {
  value       = aws_s3_bucket_website_configuration.w3_frontend_hosting_website_conf.website_endpoint
  description = "Endpoint of S3 bucket"
}
