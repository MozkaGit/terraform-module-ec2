variable "instancetype" {
  default = "t2.nano"
}

variable "aws_name_tag" {
  default = {
    Name = "ec2-mozka"
  }
}