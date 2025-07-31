
Running local

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
