data "aws_eips" "backend_eip" {
  tags =  {
     attached = "ec2 instance"
  }
}

resource "aws_instance" "backend_ec2" {
  availability_zone = var.av_zone
  ami           = var.ami
  instance_type = var.instance_type
  # count         = var.ec2_instance_count
  subnet_id     = var.ec2_subnet_id
  associate_public_ip_address = true
  key_name = aws_key_pair.backend_ec2_key_pair.id
  vpc_security_group_ids = [aws_security_group.backend_ec2_security_group.id]
  tags = {
    instance_name     = "backend with haproxy"
    environment       = "production"
    component         = "backend"
  }
  provisioner "file" {
    source      = templatefile("./modules/ec2/file/haproxy.cfg", { website_endpoint = var.website_endpoint})
    destination = "/home/"
  }
  provisioner "file" {
    source      = "./modules/ec2/file/rsyslog.conf"
    destination = "/home/"
  }
  provisioner "file" {
    source      = "./modules/ec2/file/kickstart.sh"
    destination = "/home/"
  }
  provisioner "remote-exec" {
    inline = [
      
    ]
  }
}

resource "aws_key_pair" "backend_ec2_key_pair" {
  key_name   = "aws_ec2"
  public_key = file(var.key_pair)
}

resource "aws_ebs_volume" "backend_ec2_ebs" {
  availability_zone = aws_instance.backend_ec2.availability_zone
  size              = 20

  tags = {
    ec2_name = aws_instance.backend_ec2.arn
  }
}

resource "aws_volume_attachment" "backend_ec2_ebs_attachment" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.backend_ec2_ebs.id
  instance_id = aws_instance.backend_ec2.id
}

# resource "aws_eip" "backend_ec2_eip" {
#   domain   = "vpc"
#   tags     = {
#     environment = "production"
#     attached    = "ec2 instance"
#   }
# }

resource "aws_eip_association" "backend_ec2_eip_association" {
  instance_id   = aws_instance.backend_ec2.id
  allocation_id = data.aws_eips.backend_eip.allocation_ids[0]
}

resource "aws_security_group" "backend_ec2_security_group" {
  vpc_id      = var.vpc_id
  name        = "ec2 instance sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "frontend"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  # ingress {
  #   description      = "backend"
  #   from_port        = 8000
  #   to_port          = 8880
  #   protocol         = "tcp"
  #   cidr_blocks      = [var.cidr_block]
  # }
  # ingress {
  #   description      = "db"
  #   from_port        = 3302
  #   to_port          = 5432
  #   protocol         = "tcp"
  #   cidr_blocks      = [var.cidr_block]
  # }
  ingress {
    description     = "ssh"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backend with haproxy"
  }
}

output "public_ip" {
  value     =  aws_eip_association.backend_ec2_eip_association.public_ip
}

output "allocation_ids" {
  value = data.aws_eips.backend_eip.allocation_ids[0]
}

# EC2-Classic EIPs.
output "public_ips" {
  value = data.aws_eips.backend_eip.public_ips[0]
}

