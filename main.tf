terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }


//adding a coment
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ec23856b3bad62d3"
  instance_type = "t2.micro"
  key_name= "aws_key"

  tags = {
    Name = var.instance_name
  }


  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ben"
    private_key = file("/Users/ben/.ssh/id_rsa")
    timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


