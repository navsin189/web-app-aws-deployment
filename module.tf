module frontend_hosting {
    source          =   "./modules/frontend_hosting_s3/"
    www_domain_name =   var.www_domain_name
    account_id      =   var.account_id
    iam_user_name   =   var.iam_user_name
}

output "website_endpoint" {
    value = module.frontend_hosting.w3_frontend_hosting_endpoint
}