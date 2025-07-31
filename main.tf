
provider "aws" {
  region = var.region
}

resource "aws_instance" "new_ec2"{
  ami                    = var.windows_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = "iis-ec2"
  }

  user_data = file("scripts/ms_tools.ps1")
}

# output "new_ec2_public_ip" {
#   value = aws_instance.new_ec2.public_ip
# }