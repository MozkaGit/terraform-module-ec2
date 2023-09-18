variable "instancetype" {
  default = "t2.micro"
}

variable "aws_name_tag" {
  default = {
    Name = "ec2-prod-mozka"
  }
}