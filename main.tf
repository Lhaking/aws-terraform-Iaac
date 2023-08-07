resource "aws_vpc" "main" {
    cidr_block = "192.168.0.0/16"

    tags = {
      Name = "uniquesoft-vpc"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "uniquesoft-igw"
    }
}



