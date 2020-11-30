# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
     $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
     Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
     Exit
    }
}

# Update from master
Remove-Item -path $env:windir\temp\dtcbsure-bdr.zip -force -confirm:$false
wget "https://codeload.github.com/DTC-Inc/dtcbsure-bdr-appliance/zip/main" -outFile $env:windir\temp\dtcbsure-bdr.zip
Expand-Archive -path "$env:windir\temp\dtcbsure-bdr.zip" -destinationPath "$env:systemdrive\dtc" -force

& "$psScriptRoot\deploy.ps1"
