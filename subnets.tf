resource "aws_subnet" "Public_subnet_0" {
    vpc_id = aws_vpc.main.id
    cidr_block = "192.168.0.16/28"

    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet_0"
    }
    
}

resource "aws_subnet" "Public_subnet_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "192.168.0.32/28"

    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet_1"
    }
    
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "192.168.0.0/28"

    availability_zone = "eu-west-1a"
    

    tags = {
        Name = "private_subnet"
    }
}