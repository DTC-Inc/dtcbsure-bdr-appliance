param([switch]$Elevated)
Get-Disk | Where-Object IsOffline -Eq $True | Set-Disk -IsOffline $False
Update-StorageProviderCache
Get-StoragePool | ? IsPrimordial -eq $false | Set-StoragePool -IsReadOnly:$false -ErrorAction SilentlyContinue
Get-StoragePool | ? IsPrimordial -eq $false | Get-VirtualDisk | Remove-VirtualDisk -Confirm:$false -ErrorAction SilentlyContinue
Get-StoragePool | ? IsPrimordial -eq $false | Remove-StoragePool -Confirm:$false -ErrorAction SilentlyContinue
Get-PhysicalDisk | Reset-PhysicalDisk -ErrorAction SilentlyContinue
Get-Disk | ? Number -ne $null | ? IsBoot -ne $true | ? IsSystem -ne $true | ? PartitionStyle -ne RAW | % {
    $_ | Set-Disk -isoffline:$false
    $_ | Set-Disk -isreadonly:$false
    $_ | Clear-Disk -RemoveData -RemoveOEM -Confirm:$false
    $_ | Set-Disk -isreadonly:$true
    $_ | Set-Disk -isoffline:$true
}
Get-Disk | Where Number -Ne $Null | Where IsBoot -Ne $True | Where IsSystem -Ne $True | Where PartitionStyle -Eq RAW | Group -NoElement -Property FriendlyName
$physicaldisk = Get-PhysicalDisk -CanPool $true
$storagesubsystem = Get-StorageSubsystem |Select-Object -ExpandProperty FriendlyName
New-StoragePool -FriendlyName pool0 -StorageSubsystemFriendlyName $storagesubsystem -PhysicalDisks $physicalDisk
New-Volume -FriendlyName "storage" -FileSystem NTFS -StoragePoolFriendlyName "pool0" -Size 7.27TB -ResiliencySettingName Mirror -AccessPath D:
