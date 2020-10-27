Start-Process powershell -verb runas -ArgumentList "-file $PSScriptRoot\s2d-deploy.ps1" -Wait
Start-Process powershell -verb runas -ArgumentList "-file $PSScriptRoot\create-share.ps1" -Wait
Start-Process powershell -verb runas -ArgumentList "-file $PSScriptRoot\deploy-networking.ps1" -wait
Start-Process powershell -verb runas -ArgumentList "-file $PSScriptRoot\dld-bob.boot.iso.ps1" -wait
Start-Process powershell -verb runas -ArgumentList "-file $PSScriptRoot\agent-install.ps1" -wait