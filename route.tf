# Creating route table for public subnet 0
resource "aws_route_table" "public_route_0" {
  vpc_id = aws_vpc.main.id
  count = 2
  tags = {
    Name = element(var.route_table_names, count.index)
  }
}

resource "aws_route" "public_route" {
    count = 2
    route_table_id = element(aws_route_table.public_route_0.*.id, count.index)
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id  
}

# Associating route table with subnet 0
resource "aws_route_table_association" "public_route_0_association" {
    count = 2
    route_table_id = element(aws_route_table.public_route_0.*.id, count.index)
    subnet_id = element(aws_subnet.Public_subnet_0.*.id, count.index)
}

# Create an elastic ip to use as allocation id for Nat GW

resource "aws_eip" "nat" {
    domain = "vpc"
    depends_on = [aws_internet_gateway.gw]

    tags = {
      Name = "eip"
    }
  
}
resource "aws_nat_gateway" "nat_gw" {
    allocation_id = "${aws_eip.nat.id}"
    subnet_id = aws_subnet.Public_subnet_0.*.id[0]

    depends_on = [aws_eip.nat]
}

# Create route table for private subnet
resource "aws_route_table" "private_subnet" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {
        Name = "private_subnet"
    }           

}
    
resource "aws_route_table_association" "private_subnet_association" {
    route_table_id  = aws_route_table.private_subnet.id
    subnet_id = aws_subnet.private_subnet.id
}




