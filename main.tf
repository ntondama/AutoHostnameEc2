provider "aws" {
  region = "ap-southeast-2"
}

variable "server_name" {
  description = "Name of the server (will be set as hostname)"
  default     = "ec2-auto-server1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-2a"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.main.id

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

resource "aws_instance" "auto_hostname" {
  ami                    = "ami-0df4b2961410d4cff" # Amazon Linux 2 in ap-southeast-2 (Sydney)
  instance_type          = "t2.micro"
  key_name               = "NTsydney"  # Replace with your actual key name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname ${var.server_name}
              echo "127.0.0.1   ${var.server_name}" >> /etc/hosts
              EOF

  tags = {
    Name = var.server_name
  }
}

output "instance_public_ip" {
  value = aws_instance.auto_hostname.public_ip
}

output "instance_hostname" {
  value = var.server_name
}
