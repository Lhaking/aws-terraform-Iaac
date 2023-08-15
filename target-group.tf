resource "aws_lb_target_group" "main" {
    name = "lkg-lb-tg"
    port = 80
    protocol ="HTTP"
    vpc_id = aws_vpc.main.id

}
resource "aws_lb_target_group_attachment" "main" {
  count = 2
  target_id = element(aws_instance.webserver1.*.id, count.index)
  target_group_arn = aws_lb_target_group.main.arn
  port             = 80
}

resource "aws_lb" "main" {
    name = "LKGLB"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.allow_tls.id]
    subnets = [for x in aws_subnet.Public_subnet_0: x.id]
}

resource "aws_lb_listener" "main" {
    load_balancer_arn = aws_lb.main.arn
    port = 80
    protocol = "HTTP"


default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.main.arn 
    }
}

  
    
  
