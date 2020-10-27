Get-VMNetworkadapter -ManagementOS  | Where-Object -Property "Name" -notlike "Container NIC*" | Remove-VMNetworkAdapter
Get-VMSwitch | Where-Object -Property Name -notlike "Default Switch" | Remove-VMSwitch -Force
Get-NetSwitchteam| Remove-NetSwitchTeam
$toTeam = Get-NetAdapter | Where-Object -Property InterfaceDescription -like "Intel*" | Select-Object -ExpandProperty Name
New-NetSwitchTeam -Name TEAM0 -TeamMembers $toTeam
New-VMSwitch -Name TEAM0 -NetAdapterName TEAM0
Rename-VMNetworkAdapter -Name TEAM0 -NewName SHARED-TEAM0 -ManagementOS
ping 8.8.8.8 -n 30