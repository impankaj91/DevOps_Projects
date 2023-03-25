variable "cidr_block"{
    description = "define the range of network."
}

variable "env_prefix"{
    description = "type of environment."
}

variable "public_subnet_block"{
    description = "define subnet block of vpc."
}

variable "avail_zone"{
    description = "define availblity zone of server."
}

variable "ec2_type"{
    description = "Specification of machine"
}