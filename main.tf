terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "app_server" {
  ami             = "ami-0443305dabd4be2bc"
  instance_type   = "t2.micro"
  key_name        = "key_ohio"
  user_data	= file("file.sh")
  security_groups = [ "ssh+http+https" ]

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

# resource "aws_security_group" "Docker" {
#   tags = {
#     type = "terraform-test-security-group"
#   }
# }

# output "instance_id" {
#   description = "ID of the EC2 instance"
#   value       = aws_instance.app_server.id
# }

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

