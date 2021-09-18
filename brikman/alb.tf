resource "aws_lb" "playsdev-alb" {
  name               = "playsdev-alb"
  internal           =  false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.playsdev-sg.id]
  subnets	     = [aws_subnet.playsdev-public-subnet.id,aws_subnet.playsdev-public-subnet-2.id]	
  enable_deletion_protection = false


  tags = {
    Name = "playsdev-terraform-alb"
}
}
