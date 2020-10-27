wget "https://automate.dtctoday.com/LabTech/Deployment.aspx?InstallerToken=803804a6951441c88b8ad92968a7f3c8" -outFile $env:windir\temp\agent_install.exe
$agentInstallPath = "$env:windir\temp\agent_install.exe"
Start-Process -filePath $agentInstallPath -argumentList "/quiet /install"

