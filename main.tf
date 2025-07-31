
provider "aws" {
  region = var.region
}

resource "aws_instance" "blue" {
  ami                    = var.windows_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = "iis-blue"
  }

  user_data = file("scripts/bootstrap_blue.ps1")
}

resource "aws_instance" "green" {
  ami                    = var.windows_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = "iis-green"
  }

  user_data = file("scripts/bootstrap_green.ps1")
}

output "blue_ip" {
  value = aws_instance.blue.public_ip
}

output "green_ip" {
  value = aws_instance.green.public_ip
}