resource "aws_instance" "jump-host" {
 ami           = "ami-0557a15b87f6559cf"
 instance_type = "t3.micro"
 associate_public_ip_address = true
 subnet_id = aws_subnet.bastion.id
 key_name = "nagy-kh"

 vpc_security_group_ids = [aws_security_group.pub-secgroup.id]

 tags = {
    Name = "nagy-jumphost"
  }

}

resource "aws_instance" "private-ec2-1" {
 ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.medium"
  associate_public_ip_address = false
  key_name = "nagy-kh"

  subnet_id = aws_subnet.private-sub1.id
  vpc_security_group_ids = [aws_security_group.pub-secgroup.id]
  tags = {
    Name = "nagy-sonarqube"
  }
  

}

resource "aws_instance" "private-ec2-2" {
 ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.medium"
   key_name = "nagy-kh"

  associate_public_ip_address = false
  subnet_id = aws_subnet.private-sub2.id
  vpc_security_group_ids = [aws_security_group.pub-secgroup.id]
  tags = {
    Name = "nagy-nexus"
  }
}
  