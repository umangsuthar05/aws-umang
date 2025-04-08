resource "aws_route53_zone" "main" {
  name = "terrafrom-test.com"
}

resource "aws_route53_zone" "demo" {
  name = "demo.terrafrom-test.com"

  tags = {
    Environment = "demo"
  }
}

resource "aws_instance" "awsdemo" {
  ami            = "ami-0ca285d4c2cda3300"
  instance_type  = "t3.nano"
  subnet_id   = aws_subnet.private-subnet.id

  tags = {
    Name = "demo-instance"
  }
}
resource "aws_vpc" "demo" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "demo"
  }
}
resource "aws_subnet" "private-subnet" {
  vpc_id     = "${aws_vpc.demo.id}"
  cidr_block = "192.168.51.0/24"

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_route53_zone" "private" {
  name = "demo-instance-terrafrom-test.com"

  vpc {
    vpc_id = aws_vpc.demo.id
  }
}