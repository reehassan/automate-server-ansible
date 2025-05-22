provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "ansible_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "ansible_sg" {
  name        = "ansible_sg"
  description = "Allow SSH and HTTP/HTTPS"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
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

resource "aws_instance" "ansible_server" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ansible_key.key_name

  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  tags = {
    Name = "ansible-server-${count.index + 1}"
  }
}