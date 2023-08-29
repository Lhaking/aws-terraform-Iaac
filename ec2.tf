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
# resource "aws_launch_configuration" "main" {
#   name_prefix   = "main-"
#   image_id      = "ami-01dd271720c1ba44f"  
#   instance_type = "t2.micro"
# }


resource "aws_launch_template" "main" {
  name = "main"

  ebs_optimized = true
  # iam_instance_profile {
  #   name = "test"
  # }
  image_id = "ami-01dd271720c1ba44f"
  instance_initiated_shutdown_behavior = "terminate"
  user_data = filebase64("${path.module}/apache-script.sh")
  instance_type = "t2.micro"
  key_name = "test"
  instance_market_options {
    market_type = "spot"
  }

  monitoring {
    enabled = true
  }
  placement {
    availability_zone = "eu-west-1"
  }
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "test"
    }
  }
}

resource "aws_autoscaling_group" "main" {
  name                 = "main-asg"
  min_size             = 2
  max_size             = 5
  desired_capacity     = 4

  launch_template {
    id = aws_launch_template.main.id
    version = "$Latest"
  }

  vpc_zone_identifier = aws_subnet.Public_subnet_0.*.id

  # Additional settings can be configured here
  # health_check_type    = "EC2"
  # termination_policies = ["OldestInstance"]

  tag {
    key                 = "Environment"
    value               = "Production"
    propagate_at_launch = true
  }
}









    
    

















  
