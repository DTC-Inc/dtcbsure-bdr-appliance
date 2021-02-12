# Init errorCatch variable
Write-Host "Warning!! This will cause data loss if this is run!"
$killScript = Read-Host "Do you want to kill this script? (y or n)"

if ($killScript -eq "y") {
    exit
}

Set-ExecutionPolicy Bypass -Force

& "$psScriptRoot\s2d-deploy.ps1"
& "$psScriptRoot\create-share.ps1"
& "$psScriptRoot\deploy-networking.ps1"
& "$psScriptRoot\deploy-openssh.ps1"
& "$psScriptRoot\agent-install.ps1"
& "$psScriptRoot\dld-bob.boot.iso.ps1"
& "$psScriptRoot\enableSystemRestore.ps1"


# Rename Computer
$newName = Read-Host "Input the DTCBSURE Appliance Name (DTCBSURE-$ASSETTAG): "

if ($newName) {
    Rename-Computer -NewName $
}

# Insert Product Key
$productKey = Read-Host "What is the product key? (with dashes)"
slmgr /ipk $productKey

# Success check
$successful = Read-Host "Did everything complete successfully? (y or n)"

if ( $successful -ne "y" ){
    Write-Host "Please run this script until all issues are resolved."
}

if ( $successful -eq "y" ){
    Read-Host "Please remember to configure the UEFI and IPMI."
}

# Reboot
$reboot = Read-Host "Do you want to reboot? (y or n)"

if ($reboot -eq "y"){
    shutdown -r -t 00 -f
}

