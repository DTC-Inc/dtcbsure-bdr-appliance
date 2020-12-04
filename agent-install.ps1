wget "https://s3.us-west-002.backblazeb2.com/public-dtc/repo/dtcbsure-bdr/agent_install.msi" -outFile $env:windir\temp\agent_install.exe
$agentInstallPath = "$env:windir\temp\agent_install.exe"
Start-Process -filePath $agentInstallPath -argumentList "/quiet /install"
