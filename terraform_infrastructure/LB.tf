resource "aws_lb" "public-lb" {
  name               = "nagy-pub-lb"
  internal           = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.pub-secgroup.id]
  subnets            = [aws_subnet.bastion.id, aws_subnet.pub-sub-2.id]
  tags = {
    Name = "nagy-public-lb"
  }
}

resource "aws_lb_target_group" "targetGroup1" {
  name     = "nagy-targetGroup1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
  tags = {
    Name = "nagy-targetgroup1"
  }
}
resource "aws_lb_target_group_attachment" "attach-priv1" {
  target_group_arn = aws_lb_target_group.targetGroup1.arn
  target_id        = aws_instance.private-ec2-1.id
  port             = 80
}
resource "aws_lb_listener" "listener1" {
  load_balancer_arn = aws_lb.public-lb.arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetGroup1.arn
  }
}

resource "aws_lb_target_group" "targetGroup2" {
  name     = "nagy-targetGroup2"
  port     = 81
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
  tags = {
    Name = "nagy-targetgroup2"
  }
}
resource "aws_lb_target_group_attachment" "attach-priv2" {
  target_group_arn = aws_lb_target_group.targetGroup2.arn
  target_id        = aws_instance.private-ec2-2.id
  port             = 81
}
resource "aws_lb_listener" "listener2" {
  load_balancer_arn = aws_lb.public-lb.arn
  protocol          = "HTTP"
  port              = 81
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetGroup2.arn
  }
}