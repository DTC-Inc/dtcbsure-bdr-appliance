# Prompt User for Temp Link To Automate Tenant Install MSI
$exeUrl = Read-Host "Enter the link for the Automate tenant agent exe installer."

wget "$exeUrl" -outFile $env:windir\temp\agent_install.exe
$agentInstallPath = "$env:windir\temp\agent_install.exe"
Start-Process -filePath $agentInstallPath -argumentList "/quiet /install"
