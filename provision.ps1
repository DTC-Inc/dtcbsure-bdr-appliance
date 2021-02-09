# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
     $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
     Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
     Exit
    }
}

# ProgramData path update. 
$oldPath = Test-Path -path $env:systemdrive\dtc

if ( $oldPath -eq $true ) {   
    robocopy $env:systemdrive\dtc $env:programdata\DTC /mir
    $psScriptRoot = "$env:programdata\dtc\dtcbsure-bdr-appliance-main"
    Remove-Item -path $env:public\Desktop\Provision.lnk -force
    Remove-Item -literalPath $env:systemdrive\dtc -force -recurse
    
    # Create new shortcut
    $wshShell = New-Object -comObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut("$env:public\Desktop\Provision.lnk")
    $shortcut.TargetPath = "powershell.exe -executionPolicy bypass -file $env:programdata\dtc\dtcbsure-bdr-appliance-main\provision.ps1"
    $shortcut.Save()
    
}


# Update from master
Remove-Item -path $env:windir\temp\dtcbsure-bdr.zip -force -confirm:$false
wget "https://codeload.github.com/DTC-Inc/dtcbsure-bdr-appliance/zip/main" -outFile $env:windir\temp\dtcbsure-bdr.zip
Expand-Archive -path "$env:windir\temp\dtcbsure-bdr.zip" -destinationPath "$env:programdata\dtc" -force

& "$psScriptRoot\deploy.ps1"






