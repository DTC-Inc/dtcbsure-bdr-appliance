Get-VMNetworkadapter -managementOS  | Where-Object -property "name" -notlike "Container NIC*" | Remove-VMNetworkAdapter
Get-VMSwitch | Where-Object -property name -notlike "Default Switch" | Remove-VMSwitch -force
Get-NetSwitchteam| Remove-NetSwitchTeam
$newName = Read-Host -Prompt "Input the DTCBSURE Appliance Name (DTCBSURE-$SERVICETAG): "
Rename-Computer -NewName $newName
$toTeam = Get-NetAdapter | Where-Object -property interfaceDescription -like "Intel*" | Select-Object -expandProperty name
New-NetSwitchTeam -name TEAM0 -teamMembers $toTeam
New-VMSwitch -name TEAM0 -netAdapterName TEAM0
Rename-VMNetworkAdapter -name TEAM0 -newName SHARED-TEAM0 -managementOS
ping 8.8.8.8 -n 30