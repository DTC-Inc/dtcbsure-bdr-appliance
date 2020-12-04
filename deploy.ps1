# Init errorCatch variable
Write-Host "Warning!! This will cause data loss if this is run!"
$killScript = Read-Host "Do you want to kill this script? (y or n)"



if ($killScript -eq "y") {
    exit
}


& "$psScriptRoot\s2d-deploy.ps1"
& "$psScriptRoot\create-share.ps1"
& "$psScriptRoot\deploy-networking.ps1"
& "$psScriptRoot\agent-install.ps1"
& "$psScriptRoot\dld-bob.boot.iso.ps1"
& "$psScriptRoot\delete-users.ps1"


$newName = Read-Host "Input the DTCBSURE Appliance Name (DTCBSURE-$SERVICETAG): "
Rename-Computer -NewName $newName
