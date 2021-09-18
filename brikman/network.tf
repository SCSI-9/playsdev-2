#################################################################
resource "aws_vpc" "playsdev_vpc" {
  cidr_block = "33.3.0.0/16"

  tags = {
    Name = "playsdev-vpc"
  }
}

#################################################################
resource "aws_internet_gateway" "playsdev-ig" {
  vpc_id = aws_vpc.playsdev_vpc.id

  tags = {
    Name = "playsdev-ig"
  }
}

#################################################################
resource "aws_route_table" "playsdev-rt" {
  vpc_id = aws_vpc.playsdev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.playsdev-ig.id
  }

  tags = {
    Name = "playsdev-rt"
  }
}

#################################################################
resource "aws_subnet" "playsdev-public-subnet" {
  vpc_id = aws_vpc.playsdev_vpc.id
  cidr_block = "33.3.1.0/24"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "playsdev-subnet"
  }
}

###############################################################
resource "aws_subnet" "playsdev-public-subnet-2" {
  vpc_id = aws_vpc.playsdev_vpc.id
  cidr_block = "33.3.2.0/24"
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "playsdev-subnet-public-2"
  }
}

#################################################################

resource "aws_subnet" "playsdev-private-subnet" {
  vpc_id = aws_vpc.playsdev_vpc.id
  cidr_block = "33.3.3.0/24"
  availability_zone = "eu-central-1a"
  tags = {
    "Name" = "playsdev-subnet-private"
  }
}
################################################################

resource "aws_subnet" "playsdev-private-subnet-2" {
  vpc_id = aws_vpc.playsdev_vpc.id
  cidr_block = "33.3.4.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    "Name" = "playsdev-subnet-private-2"
  }
}
###############################################################
resource "aws_db_subnet_group" "playsdev-db-subnet" {
  name       = "playsdev-db-subnet"  
  subnet_ids = [aws_subnet.playsdev-private-subnet.id,aws_subnet.playsdev-private-subnet-2.id]

  tags = {
        Name = "playsdev-db-subnet" 
    }

}
##################################################################

#################################################################
resource "aws_security_group" "playsdev-sg" {
  vpc_id = aws_vpc.playsdev_vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    description = "RDS from VPC"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    description = "SSH for VPC"
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"]
  }


ingress {
    description = "PING for VPC"
    from_port = 8
    protocol = "icmp"
    to_port = -1
    cidr_blocks = [
      "0.0.0.0/0"]
  }






  ingress {
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }


 ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["33.3.0.0/16"]
  } 



  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
    ipv6_cidr_blocks = [
      "::/0"]
  }

  tags = {
    Name = "playsdev-sg"
  }
}



