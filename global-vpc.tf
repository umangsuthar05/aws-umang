provider "aws" {
  region     = "ap-southeast-1"
  access_key = "demo"
  secret_key = "demo"
}

resource "aws_vpc" "demo" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "demovpc"
  }
}
resource "aws_subnet" "public-subnet1" {
  vpc_id     = "${aws_vpc.demo.id}"
  cidr_block = "192.168.51.0/24"

  tags = {
    Name = "public-subnet1"
  }
}
resource "aws_subnet" "public-subnet2" {
  vpc_id     = "${aws_vpc.demo.id}"
  cidr_block = "192.168.52.0/24"

  tags = {
    Name = "public-subnet2"
  }
}

resource "aws_subnet" "private-subnet1" {
  vpc_id     = "${aws_vpc.demo.id}"
  cidr_block = "192.168.53.0/24"

  tags = {
    Name = "private-subnet1"
  }
}
resource "aws_subnet" "private-subnet2" {
  vpc_id     = "${aws_vpc.demo.id}"
  cidr_block = "192.168.54.0/24"

  tags = {
    Name = "private-subnet2"
}
}

output "vpc-cidr" {
    value = aws_vpc.demo.cidr_block
}