resource "aws_subnet" "Public_subnet_0" {
    vpc_id = aws_vpc.main.id
    count = 2
    availability_zone = element(var.availability_zone, count.index)
    cidr_block = element(var.cidr_block, count.index)
    map_public_ip_on_launch = true

    tags = {
        Name = element(var.subnet_names, count.index)
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