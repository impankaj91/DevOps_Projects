resource "aws_subnet" "dev-subnet"{
    vpc_id = var.vpc_id 
    cidr_block = var.public_subnet_block
    availability_zone = var.avail_zone
    tags = {
        Name = "${var.env_prefix}-public-subnet"
    }
}

resource "aws_internet_gateway" "dev_igw"{
    vpc_id = var.vpc_id
    tags = {
        Name = "${var.env_prefix}-igw"
    }
}

resource "aws_route_table" "public_rt"{
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev_igw.id
    }
    tags = {
        Name = "${var.env_prefix}-public-rt"
    }
}

resource "aws_route_table_association" "subnet_association"{
    subnet_id = aws_subnet.dev-subnet.id
    route_table_id = aws_route_table.public_rt.id
}