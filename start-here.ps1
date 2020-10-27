Start-Process powershell -verb runAs -argumentList "-file $psScriptRoot\s2d-deploy.ps1" -Wait
Start-Process powershell -verb runAs -argumentList "-file $psScriptRoot\create-share.ps1" -Wait
Start-Process powershell -verb runAs -argumentList "-file $psScriptRoot\deploy-networking.ps1" -wait
Start-Process powershell -verb runAs -argumentList "-file $psScriptRoot\dld-bob.boot.iso.ps1" -wait
Start-Process powershell -verb runAs -argumentList "-file $psScriptRoot\agent-install.ps1" -wait