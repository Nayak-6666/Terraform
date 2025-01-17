provider "aws"{
region = "us-east-1"
}

resource "aws_vpc" "vpc1"{
id       = "vpc-0194d26b6dcff5e36"
tags = {
Name = "vpc1"
  }
}

resource "aws_security_group" "web" {
  vpc_id      = vpc-0194d26b6dcff5e36"
  name        = "web-sg"
  description = "Allow HTTP and SSH traffic"

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

  ingress {
    from_port   = 8000
    to_port     = 8000
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

resource "aws_instance" "web" {
  ami                         = "ami-01fccab91b456acc2"  # Update to your desired AMI ID
  instance_type               = "t2.micro"
  key_name                    = "Onekey"
  user_data                   = file("userdata.sh")
  vpc_security_group_ids      = [aws_security_group.web.id]

  tags = {
    Name = "WordPressServer"
  }
}

output "security_group_id" {
  value = aws_security_group.web.id
}
