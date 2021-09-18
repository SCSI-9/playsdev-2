variable "key_name" {}
############################################################
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}


###############################################################

resource "aws_instance" "web" {
  ami           = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.playsdev-public-subnet.id
  vpc_security_group_ids = [aws_security_group.playsdev-sg.id]
  key_name      = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true
  tags = {
    Name = "HelloWorld"
  }
}

################################################################
output "ssh_key" {
  description = "ssh key generated by terraform"
  value       = tls_private_key.example.public_key_openssh
}

