# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Run Windows Update
Write-Host "Running Windows Update..."
Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
Import-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install -AutoReboot

# Install SQL Server Express
$SqlInstallerUrl = "https://go.microsoft.com/fwlink/?linkid=866658"
$SqlInstallerPath = "$env:TEMP\SQLEXPR_x64_ENU.exe"
Invoke-WebRequest -Uri $SqlInstallerUrl -OutFile $SqlInstallerPath
Start-Process -FilePath $SqlInstallerPath -ArgumentList "/Q /ACTION=Install /FEATURES=SQLEngine /INSTANCENAME=SQLEXPRESS /SQLSVCACCOUNT='NT AUTHORITY\\NETWORK SERVICE' /SQLSYSADMINACCOUNTS='Administrator' /SECURITYMODE=SQL /SAPWD='Str0ngP@ssw0rd!' /TCPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS" -Wait

# Harden IIS
Import-Module WebAdministration
Set-WebConfigurationProperty -Filter /system.webServer/security/requestFiltering -Name allowDoubleEscaping -Value False -PSPath IIS:\
Set-WebConfigurationProperty -Filter /system.webServer/directoryBrowse -Name enabled -Value False -PSPath IIS:\
# Add security headers
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/httpProtocol/customHeaders" -name "." -value @{name='X-Content-Type-Options';value='nosniff'}
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/httpProtocol/customHeaders" -name "." -value @{name='X-Frame-Options';value='DENY'}
Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/httpProtocol/customHeaders" -name "." -value @{name='X-XSS-Protection';value='1; mode=block'}

# Configure Windows Firewall
New-NetFirewallRule -DisplayName "Allow HTTP" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow HTTPS" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow
# Block remote SQL access
New-NetFirewallRule -DisplayName "Block SQL Server Remote" -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Block

# Optional: Create a simple index.html
$sitePath = "C:\inetpub\wwwroot"
$indexFile = Join-Path $sitePath "index.html"
"<html><body><h1>IIS Green Instance with SQL Server Express (Hardened)</h1></body></html>" | Out-File -Encoding utf8 $indexFile
