variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = "list"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  type    = "list"
  default = ["us-east-1a", "us-east-1b"]
}

variable "ami" {
  default = "ami-0a887e401f7654935"
}

variable "instance_type" {
  default = "t2.micro"
}
