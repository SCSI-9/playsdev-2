resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  vpc      = true
}

resource "aws_nat_gateway" "example" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.playsdev-private-subnet.id
}


