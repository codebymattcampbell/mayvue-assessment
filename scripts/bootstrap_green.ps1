# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Optional: Create a simple index.html
$sitePath = "C:\inetpub\wwwroot"
$indexFile = Join-Path $sitePath "index.html"
"<html><body><h1>IIS Green Instance</h1></body></html>" | Out-File -Encoding utf8 $indexFile
