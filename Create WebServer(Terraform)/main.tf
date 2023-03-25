provider "aws"{
    region = "ap-south-1"
}

terraform {
    backend "s3" {
      bucket   = "terraformstate-pankaj"
      key      = "webserver/terraform.tfstate"
      region = "ap-south-1"
    }
    
}

resource "aws_vpc" "dev_vpc"{
    cidr_block = var.cidr_block
    tags = {
        Name = "${var.env_prefix}-vpc"
    }
}

######
# Subnet Module #
module "my-subnet"{
    source = "./modules/subnet"
    vpc_id = aws_vpc.dev_vpc.id
    env_prefix = var.env_prefix
    public_subnet_block = var.public_subnet_block
    avail_zone = var.avail_zone
}

######

resource "aws_security_group" "sg"{
    name = "${var.env_prefix}-sg"
    vpc_id = aws_vpc.dev_vpc.id 

    ingress {
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
    }

    ingress {
        from_port = 8080
        to_port = 8080
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
    }

    egress{
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "-1"
    }

    tags = {
        Name = "${var.env_prefix}-sg"
    }
}

############
######## WebServer Module ##########
module "my-webserver"{
    source = "./modules/webserver"
    subnet_id = module.my-subnet.subnet.id
    ec2_type = var.ec2_type
    avail_zone = var.avail_zone
    vpc_security_group_ids = aws_security_group.sg.id
    env_prefix = var.env_prefix
}


############