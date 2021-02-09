# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
     $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
     Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
     Exit
    }
}


# ProgramData path update. 
if ( $oldPath ) {   
    New-Item -path $env:programdata -name "DTC" -itemType "directory"
    $psScriptRoot = $env:programdata\dtc\dtcbsure-bdr-appliance-main
    Remove-Item -path $env:public\Desktop\Provision.lnk -force
    Remove-Item -literalPath $env:systemdrive\dtc -force -recurse
    
    # Create new shortcut
    $wshShell = New-Object -comObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut("$env:public\Desktop\Provision.lnk")
    $shortcut.TargetPath = "powershell.exe -policy byppass -file $env:programdata\dtc\dtcbsure-bdr-appliance-main\provision.ps1"
    $shortcut.Save()
    
}

& "$psScriptRoot\deploy.ps1"



# Update from master
Remove-Item -path $env:windir\temp\dtcbsure-bdr.zip -force -confirm:$false
wget "https://codeload.github.com/DTC-Inc/dtcbsure-bdr-appliance/zip/main" -outFile $env:windir\temp\dtcbsure-bdr.zip
Expand-Archive -path "$env:windir\temp\dtcbsure-bdr.zip" -destinationPath "$env:programdata\dtc" -force


