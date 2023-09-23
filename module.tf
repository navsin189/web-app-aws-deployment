module custom_vpc {
    source               =   "./modules/vpc/"
    cidr_block           =   var.cidr_block
    ec2_subnet           =   var.ec2_subnet
    av_zone              =   var.av_zone
}

module ec2_backend {
    source               =   "./modules/ec2/"
    ami                  =   var.ami
    instance_type        =   var.instance_type
    cidr_block           =   var.cidr_block
    ec2_subnet_id        =   module.custom_vpc.subnet_id
    vpc_id               =   module.custom_vpc.vpc_id
    ec2_instance_count   =   var.ec2_instance_count
    av_zone              =   var.av_zone
    key_pair             =   var.key_pair
    website_endpoint     =   module.frontend_hosting.w3_frontend_hosting_endpoint
}

module frontend_hosting {
    source               =   "./modules/frontend_hosting_s3/"
    www_domain_name      =   var.www_domain_name
    account_id           =   var.account_id
    iam_user_name        =   var.iam_user_name
    public_ip            =   module.ec2_backend.public_ip
}

output "website_endpoint" {
    value      = module.frontend_hosting.w3_frontend_hosting_endpoint
}

output "public_ip" {
    value      = module.ec2_backend.public_ip
}

output "allocation_ids" {
  value = module.ec2_backend.allocation_ids
}

# EC2-Classic EIPs.
output "public_ips" {
  value = module.ec2_backend.public_ips
}