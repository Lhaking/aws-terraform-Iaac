resource "aws_instance" "webserver1" {

    ami = "ami-01dd271720c1ba44f"
    count = 2
    instance_type = "t2.micro"
    subnet_id = element(aws_subnet.Public_subnet_0.*.id, count.index)
    key_name = "test"
    user_data = filebase64("apache-script.sh")
    associate_public_ip_address = true
    security_groups = [aws_security_group.allow_tls.id]
    tags = {
      Name = "web"
    }
  
}



resource "aws_security_group" "allow_tls" {
    name = "allow_tls"
    description = "Allow Tls inbound traffic"
    vpc_id = aws_vpc.main.id

    ingress {
        description = "Public access to website"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     ingress  {
        description = "Public access to website"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress  {
         description = "ssh access to server by admin"
         from_port = 22
         to_port = 22
         protocol = "tcp"
         cidr_blocks = ["80.193.62.172/32"]
     }

    egress { 
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "allow tls"
    }
}    



  
