data "aws_ami" "os"{
    most_recent = true
    filter {
        name = "name"
        values = ["al2022-ami-*-kernel-*-x86_64"]
    }
}

output "aws_ami_id"{
    value = data.aws_ami.os.id
}

resource "aws_instance" "web_server"{
    ami = data.aws_ami.os.id
    instance_type = var.ec2_type
    availability_zone = var.avail_zone

    //vpc_id = aws_vpc.dev_vpc.id
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.vpc_security_group_ids]

    associate_public_ip_address = true
    key_name = "server-key"

    user_data = file("nginx.sh")

        tags = {
        Name = "${var.env_prefix}-machine"
    }
}