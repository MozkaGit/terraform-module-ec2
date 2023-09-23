data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "ec2" {
  ami             = data.aws_ami.app_ami.id
  instance_type   = var.instancetype
  key_name        = var.key-pairs
  security_groups = ["${aws_security_group.sg.name}"]
  tags            = var.aws_name_tag

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private-key)
      host        = self.public_ip
    }
  }
}

resource "aws_security_group" "sg" {

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.ec2.id
  domain   = "vpc"

  provisioner "local-exec" {
    command = "echo IP: ${aws_eip.lb.public_ip} >> infos_ec2.txt && echo ID: ${aws_instance.ec2.id} >> infos_ec2.txt && echo AZ: ${aws_instance.ec2.availability_zone} >> infos_ec2.txt"
  }
}