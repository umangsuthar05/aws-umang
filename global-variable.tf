variable "stack_name" {
  type        = string
  description = "This will degine the name of the Application."
}

variable "aws_region" {
  type        = string
  description = "This will define AWS Region to create resoureces."
}

variable "instance-type" {
  type        = string
  description = "This is instance type"
  default     = "t3.nano"
}

variable "private_subnets_cidr" {
  type    = list(any)
  default = ["192.168.51.0/24", "192.168.52.0/24", "192.168.53.0/24", "192.168.54.0/24"]
}

variable "availability_zones" {
  type    = list(any)
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}