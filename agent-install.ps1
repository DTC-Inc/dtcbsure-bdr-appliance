# Prompt User for Temp Link To Automate Tenant Install MSI
$exeUrl = Read-Host "Enter the link for the Automate tenant agent exe installer."

# Install Automate
wget $exeUrl -outFile $env:windir\temp\agent_install.exe
$agentInstallPath = "$env:windir\temp\agent_install.exe"
Start-Process -filePath $agentInstallPath -argumentList "/quiet /install"

# Download MSP360
wget https://s3.amazonaws.com/cb_setups/MBS/61FAB6F1-B982-40D5-90D7-9E8D1D6968C5/DTCIncDTCBSureCloudBackup_v6.3.4.38_netv4.0_ALLEDITIONS_Setup_20201201043132.exe -outFile $env:windir\temp\dtcbsure-install.exe
& $env:windir\temp\dtcbsure-install.exe /S 2>&1
