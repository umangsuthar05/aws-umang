resource "aws_instance" "awsdemo" {
  ami            = "ami-0ca285d4c2cda3300"
  instance_type  = "t3.nano"
  subnet_id   = aws_subnet.private-subnet.id
}

output "instance_ip_addr" {
    value = aws_instance.awsdemo.private_ip
}
