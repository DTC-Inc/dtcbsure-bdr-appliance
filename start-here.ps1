# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
     $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
     Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
     Exit
    }
}

Set-ExecutionPolicy -executionPolicy unrestricted -force -scope localMachine
wget "https://codeload.github.com/DTC-Inc/dtcbsure-bdr-appliance/zip/main" -outFile $env:windir\temp\dtcbsure-bdr.zip
Expand-Archive -path "$env:windir\temp\dtcbsure-bdr.zip" -destinationPath "$env:systemdrive\dtc" -force

& "$psScriptRoot\s2d-deploy.ps1"
& "$psScriptRoot\create-share.ps1"
& "$psScriptRoot\deploy-networking.ps1"
& "$psScriptRoot\dld-bob.boot.iso.ps1"
& "$psScriptRoot\agent-install.ps1"

Set-ExecutionPolicy -executionPolicy remoteSigned -force -scope localMachine
