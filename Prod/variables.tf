variable "instancetype" {
  default = "t2.micro"
}

variable "aws_name_tag" {
  default = {
    Name = "ec2-prod-mozka"
  }
}

variable "key-pairs" {
  default = "devops-mozka"
}

variable "private-key" {
  default = "./devops-mozka.pem"
}