
provider "local" {
  # This is a placeholder provider, no backend resources needed
  
}

resource "null_resource" "blue_sim" {
  provisioner "local-exec" {
    command = "powershell.exe -Command \"Write-Host '[SIMULATION] Provisioning BLUE environment...'; Write-Host '[SIMULATION] Installing IIS on BLUE...'; Start-Sleep -Seconds 1; Write-Host '[SIMULATION] IIS installed and .NET Core app deployed to C:\\inetpub\\blue'\""
  }
}

resource "null_resource" "green_sim" {
  provisioner "local-exec" {
    command = "powershell.exe -Command \"Write-Host '[SIMULATION] Provisioning GREEN environment...'; Write-Host '[SIMULATION] Installing IIS on GREEN...'; Start-Sleep -Seconds 1; Write-Host '[SIMULATION] IIS installed and .NET Core app deployed to C:\\inetpub\\green'\""
  }
}

resource "null_resource" "switch_env" {
  provisioner "local-exec" {
    command = "powershell.exe -Command \"Write-Host '[SIMULATION] Switching traffic from Blue to Green deployment'; Start-Sleep -Seconds 1; Write-Host '[SIMULATION] Green deployment is now live'\""

  }
  triggers = { 
    always_run = timestamp()
  }
}


# provider "aws" {
#   region = var.region
# }

# resource "aws_instance" "blue" {
#   ami                    = var.windows_ami
#   instance_type          = var.instance_type
#   key_name               = var.key_pair
#   subnet_id              = var.subnet_id
#   vpc_security_group_ids = [var.security_group_id]
#   tags = {
#     Name = "iis-blue"
#   }

#   user_data = file("scripts/bootstrap_blue.ps1")
# }

# resource "aws_instance" "green" {
#   ami                    = var.windows_ami
#   instance_type          = var.instance_type
#   key_name               = var.key_pair
#   subnet_id              = var.subnet_id
#   vpc_security_group_ids = [var.security_group_id]
#   tags = {
#     Name = "iis-green"
#   }

#   user_data = file("scripts/bootstrap_green.ps1")
# }

# output "blue_ip" {
#   value = aws_instance.blue.public_ip
# }

# output "green_ip" {
#   value = aws_instance.green.public_ip
# }