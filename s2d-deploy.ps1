param([switch]$elevated)
Get-Disk | Where-Object isOffline -eq $true | Set-Disk -isOffline $false
Update-StorageProviderCache
Get-StoragePool | ? isPrimordial -eq $false | Set-StoragePool -isReadOnly:$false -errorAction silentlyContinue
Get-StoragePool | ? isPrimorial -eq $false | Get-VirtualDisk | Remove-VirtualDisk -confirm:$false -errorAction silentlyContinue
Get-StoragePool | ? isPrimordial -eq $false | Remove-StoragePool -confirm:$false -errorAction silentlyContinue
Get-PhysicalDisk | Reset-PhysicalDisk -errorAction silentlyContinue
Get-Disk | ? number -ne $null | ? isBoot -ne $true | ? isSystem -ne $true | ? partitionStyle -ne RAW | % {
    $_ | Set-Disk -isOffline:$false
    $_ | Set-Disk -isReadOnly:$false
    $_ | Clear-Disk -removeData -removeOEM -confirm:$false
    $_ | Set-Disk -isReadOnly:$true
    $_ | Set-Disk -isOffline:$true
}
Get-Disk | Where number -Ne $Null | Where isBoot -Ne $true | Where isSystem -Ne $true | Where partitionStyle -eq RAW | Group -noElement -property friendlyName
$physicalDisk = Get-PhysicalDisk -canPool $true
$storagesubsystem = Get-StorageSubsystem |Select-Object -expandProperty friendlyName
New-StoragePool -friendlyName pool0 -storageSubsystemFriendlyName $storageSubsystem -physicalDisks $physicalDisk
New-Volume -friendlyName "storage" -fileSystem NTFS -storagePoolFriendlyName "pool0" -UseMaximumSize -resiliencySettingName mirror -accessPath D:
