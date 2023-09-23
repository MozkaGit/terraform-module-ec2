variable "instancetype" {
  default = "t2.nano"
}

variable "aws_name_tag" {
  default = {
    Name = "NULL"
  }
}

variable "key-pairs" {
  default = "NULL"
}

variable "private-key" {
  default = "NULL"
}